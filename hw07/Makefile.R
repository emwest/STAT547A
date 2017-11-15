#do some tidying ebfore running the pipeline:
outputs <- c("gap_ordered-cont-lifeExp.rds",
             "gap_arrange-year-lifeExp.rds",
             list.files(pattern = "*.png$"))
file.remove(outputs)

##run my scripts	
source("/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/gapminder_download.R")
source("/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/gapminder_exploratory.R")
source("/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/gapminder_statistics.R")
rmarkdown::render('/Users/Adelaide/Desktop/UBC_Work/STAT545/stat547/hw07/gapminder_statistics.R')