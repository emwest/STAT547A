library(httr)
library(jsonlite)
library(xml2)
library(rvest)
library(purrr)
library(repurrrsive)
library(stringi)
library(stringr)
library(knitr)
library(tidyr)
library(dplyr)
library(plyr)
library(tidytext)
library(tidyverse)


#LET's try starwars data instead:
swchar<-GET("https://swapi.co/api/people")
swpla<-GET("https://swapi.co/api/planets")

#######work with character data first############
scres<-content(swchar)
scres$results[[2]]$name
stringi::stri_enc_detect(content(swchar, "raw"))
json<-content(swchar, as = "text", encoding = "ISO-8859-1")
thing<- fromJSON(json)
thing
#View(thing) #check out in a "readable" fashion what the swchar looks like
jsonedit(thing) #This is why inspecting your data is so important! 
                #All the interesting information is nested within results
                #The data are presented in long format

name<-thing$results$name #yep, this is a vector
(ht<-thing$results$height)
(mass<-thing$results$mass)
(skin<-thing$results$skin_color)
(eye<-thing$results$eye_color)
thing$results$name[1]

(charmass<-thing$results$mass)
map(thing, "height") #this doesn't work so well because it is pulling 
                      #the first three objects with height

ht<-map(thing, "height")
ht<-(ht[4])

esel<-function(data, attribute, selector){
  ht<-map(data, attribute)
  ht[selector]
}

char<-esel(thing, "name", 4)
ht2<-esel(thing, "height", 4)
names(ht2)
str(char)

chardf<-reduce(thing,cbind)
is.data.frame(chardf)
#str(chardf)
View(chardf)

plot(x=chardf$mass, y =chardf$height,
     xlab = "mass",
     ylab = "height")

#this ONLY works because of the shape of the data,
#because the data are organized in the long format, the columns match up,
#this would not work with more complex datasets

str(chardf$height) #yikes, because height and mass data are both being treated as character
chardf$height<-as.integer(chardf$height)
 
str(chardf$height) #yikes, because height and mass data are both being treated as characters
chardf$height<-as.integer(chardf$height)
chardf$mass<-as.integer(chardf$mass)
ggplot(chardf, aes(mass, height, colour = gender)) + geom_point()

#Select the interesting character data:
charinfo<- chardf %>% select(name, height, mass, hair_color, eye_color,
                             skin_color, birth_year,gender, homeworld)

url_planet<-chardf$homeworld[1]
planets<-GET(url_planet)
 x<-content(planets, as = "text", encoding = "ISO-8859-1")
  y<-fromJSON(x)
  View(y)
  jsonedit(y)
  y$name
  
#Get the home planets for each character based on the column in the character dataset "homeworld"
get_planet<-function(character){
  t<-filter(chardf, name==character)
  url_pl<-t$homeworld 
  plant<-GET(url_pl) 
  f<-content(plant, as = "text", encoding = "ISO-8859-1")
  q<-fromJSON(f)
  jsonedit(q)
  print(q$name)}
  
get_planet("R2-D2")
get_planet("Darth Vader")

map_chr(charinfo$name,get_planet)
chuck<-mutate(charinfo, homeplanet=map_chr(charinfo$name,get_planet) )
View(chuck)


#NYTIMES
key<-"4f650c601e234e20bd0e914c60b7f7f1"
#sample<-GET("http://api.nytimes.com/svc/topstories/v2/{section}.{response format}?api-key={apikey here}")
nyt<-GET("http://api.nytimes.com/svc/topstories/v2/movies.json?api-key=4f650c601e234e20bd0e914c60b7f7f1")
content(nyt)
#It's possible to write a function to get the data from the NYT API
get_topstories<- function (section){
  query_string<- ("http://api.nytimes.com/svc/topstories/v2/{section}.json?api-key=4f650c601e234e20bd0e914c60b7f7f1")
  article_result<-GET(query_string)
  article_content<- content(article_result, encoding = "ISO-8859-1")
  return(article_content)}

get_topstories(movies)  #access denied??

content(nyt)
status_code(nyt) #status code looks good
headers(nyt)
stringi::stri_enc_detect(content(nyt, "raw"))
nyttemp<-content(nyt, "text", encoding = "ISO-8859-1")
nytjson<-fromJSON(nyttemp)
jsonedit(nytjson)
map(nytjson, "title") #how to get rid of list prior to 
nyt_df<-reduce(nytjson, cbind)
View(nyt_df)
nyt_data<-nyt_df %>% select(section, title, abstract, url, 
                            byline, item_type, created_date,
                            published_date, des_facet, org_facet,
                            per_facet, short_url) %>% 
                            rename(c("des_facet" = "tags",
                                  "org_facet" = "produced_by",
                                  "per_facet"= "stars"))
View((nyt_data))                    

#Let's clean the byline by removing the "By" the precedes the columnist's name
str(nyt_data$byline)
is.vector(nyt_data$byline) # a vector of strings
str_view_all(nyt_data$byline, "By")
nyt_data$byline<- gsub("By","",nyt_data$byline) #Perfect
nyt_data$byline


#Select by articles that are explicitly Reviews
reviews<-nyt_data[grep("Review", nyt_data$title), ]
#View(nyt_data)
#View(reviews)
reviews<-nyt_df[grep("Review", nyt_df$title), ] %>% select(section, title, abstract, byline, published_date)
#View(nyt_data)
kable(reviews)

#Which review is the least depressing?
afinn <- get_sentiments("afinn")
str(afinn)
reviews %>% 
  unnest_tokens(word, abstract) %>% #split words
  anti_join(stop_words, by = "word") %>% #remove dull words
  inner_join(afinn, by = "word") %>% #stitch scores
  group_by(byline) %>% #and for each song
  summarise(Length = n(), #do the math
            Score = sum(score)/Length) %>%
  arrange(-Score)

is.vector(afinn$word)

?unnest
