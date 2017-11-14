library(ggplot2)
library(dplyr)
library(forcats)

#read in the data that was previously downloaded from the internet
gap<-read.delim("gapminder.tsv")

plot_loc = "/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/"
csv_loc <- "/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/"

#make a couple of exploratory figures and write them to file:
asia_data<- gap %>% filter(continent =="Asia")

png(file = paste(plot_loc,"fig_scatter-lifeExp-asia.png",sep=""),width = 600,height = 400)
ggplot(data = asia_data) +
  geom_line(mapping = aes(x = year , y = lifeExp, color = country))+ 
  ylab("life expectancy")
dev.off()

euro_data<- gap %>% filter(continent =="Europe")

png(file = paste(plot_loc,"fig_scatter-lifeExp-euro.png",sep=""),width = 600,height = 400)
ggplot(data = euro_data) +
  geom_line(mapping = aes(x = year , y = lifeExp, color = country))+ 
  ylab("life expectancy")
dev.off()

#Reorder the continents based on life expectancy, the default summary
#is median, I opted for min
gap_ord<-gap %>% select(continent, country, lifeExp, year)%>% 
  mutate (continent = fct_reorder(continent, lifeExp,min)) 
levels(gap_ord$continent)
#arrange sorted dataset based on year and life expectancy
gap_arr<- gap_ord%>% arrange(year, lifeExp)

#summarize the earlier reorder so there is only one statistic per continent
min_cont <-gap %>% group_by(continent) %>% summarize(min_life=min(lifeExp))

#make a bar graph and write the figure to file
png(file = paste(plot_loc,"fig_bar-lifeExp-continent.png",sep=""),width = 600,height = 400)
ggplot(min_cont, aes(fct_reorder(continent, min_life), min_life))+
  geom_bar(stat = "Identity")+
  xlab("continent")+
  ylab("minimum life expectancy")
dev.off()

#sort the full dataset by country, then by lifeExp
gap_sort<-gap %>% arrange(country, desc(lifeExp))

#save to .csv
write.csv(gap_ord, file = paste(csv_loc,"gap_ordered-cont-lifeExp.csv", sep=""))
write.csv(gap_arr, file = paste(csv_loc,"gap_arrange-year-lifeExp.csv", sep=""))
saveRDS(gap_ord,file = paste(csv_loc,"gap_ordered-cont-lifeExp.rds", sep=""))
saveRDS(gap_arr,file = paste(csv_loc,"gap_arrange-year-lifeExp.rds", sep=""))
