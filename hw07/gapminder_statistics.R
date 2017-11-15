library(ggplot2)
library(dplyr)
library(broom)
library(forcats)
plot_loc = "/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/"
csv_loc <- "/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/"

#import newly created data, note that writing to csv loses the ordering
gap_ord <- readRDS("/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/gap_ordered-cont-lifeExp.rds")
gap_arr <- readRDS("/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/gap_arrange-year-lifeExp.rds")

#check that ordering has been maintained:
levels(gap_ord$continent)
levels(gap_arr$continent)
#looks good.

#fit a regression for life expectancy across years, accounting for country
model.1 <- lm(lifeExp ~ year + country, data = gap_ord)
sum.1 <- summary(model.1)
tidymodel<-tidy(model.1)
str(model.1tidy)
write.csv(tidymodel, file = paste(csv_loc,"tidymodel_stats.csv", sep=""))

#find the best and worst countries for each continent:
mn <- gap_ord %>% group_by(country) %>% 
  summarize(continent = unique(continent),
  meanLife = mean(lifeExp))

asia<- mn %>% filter(continent=="Asia") %>% arrange(meanLife)
View(asia)
asia_best<-asia[(length(asia$country)-2):length(asia$country),]
asia_best
asia_worst<-asia[1:3,]
asia_worst
asia_wb<-rbind(asia_best, asia_worst) %>% droplevels
asia_wb
#a function would be a better use of time:
life_func<- function(data, place){
  cont <- data %>% filter(continent == place) %>% arrange(meanLife)
  place.worst<-cont[1:3,]
  place.best<- as.data.frame(cont[(length(cont$country)-2):length(cont$country),])
  comb <-rbind(place.worst, place.best)
  print(comb)
}


europe_wb<-life_func(mn, "Europe") %>% droplevels
is.data.frame(Europe)
#Oceania<-life_func(mn, "Oceania") - yikes, not enough countries!
americas_wb<-life_func(mn, "Americas") %>% droplevels
africa_wb<-life_func(mn, "Africa") %>% droplevels

#subset the data to make facetted graphs for each continent based on best and worst

View(africa_wb)
y<-(africa_wb$country)
p<-subset(gap_ord, country %in% y) %>% droplevels
str(p)
View(p)

afr_plot<-ggplot(data = p, aes(x=year, y=lifeExp, color = country))+geom_point()
afr_plot +facet_grid(country~.) + 
  geom_smooth(method = lm, color = "black", lwd= 0.2)
ggsave("afri_figs.png", width = 6, height = 9)

#a function might work here as well:
fig.fun <-function(data,subset,ob_name){
  ym<-(subset$country)
  pm<-subset(data, country %in% ym)
  ob_name<-ggplot(pm, aes( x = year, y = lifeExp, color = country))+geom_point()
  ob_name + facet_grid(fct_reorder(country, desc(lifeExp))~.)+ 
    geom_smooth(method = lm, color = "black", lwd= 0.2)
}

#Make figures for each continent and save to file

euro_figs<-fig.fun(gap_ord, europe_wb, euro_fig)
ggsave("euro_figs.png", width = 6, height = 9)
euro_figs
amer_figs<-fig.fun(gap_ord, americas_wb, amer_fig)
ggsave("amer_figs.png", width = 6, height = 9)
asia_figs<-fig.fun(gap_ord, asia_wb, asia_fig)
ggsave("asia_figs.png", width = 6, height = 9)
