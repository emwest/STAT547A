library(httr)
library(jsonlite)
library(xml2)
library(rvest)
library(purrr)
library(repurrrsive)
library(listviewer)
library(stringi)
library(stringr)
library(knitr)
library(tidyverse)
library(glue)

your_key<-"YOUR AUTHORIZATION KEY HERE"
#sample<-GET("http://api.nytimes.com/svc/topstories/v2/{section}.{response format}?api-key={apikey here}")
nyt<-GET("http://api.nytimes.com/svc/topstories/v2/movies.json?api-key=your_key")
#content(nyt)
status_code(nyt) #status code looks good

#It's possible to write a function to get the data from the NYT API

get_topstories<- function (section){
  query_string<- glue("http://api.nytimes.com/svc/topstories/v2/{section}.json?api-key=your_key")
  article_result<-GET(query_string)
  article_content<- content(article_result, encoding = "ISO-8859-1")
  #return(article_content)
}

nyt_movies<-get_topstories("movies")  

content(nyt)
headers(nyt)
#stringi::stri_enc_detect(content(nyt, "raw"))
nyttemp<-content(nyt, "text", encoding = "ISO-8859-1")
nytjson<-fromJSON(nyttemp)

map(nytjson, "title")  
nyt_df<-reduce(nytjson, cbind)

View(nyt_df)

#Let's clean the byline by removing the "By" the precedes the columnist's name
str(nyt_df$byline)
#is.vector(nyt_data$byline) # a vector of strings
str_view_all(nyt_df$byline, "By")
nyt_df$byline<- gsub("By","",nyt_df$byline) #Perfect
nyt_df$byline

#Select by articles that are explicitly Reviews

reviews<-nyt_df[grep("Review", nyt_df$title), ] %>% 
  select(section, title, abstract, byline, published_date)
kable(reviews)
