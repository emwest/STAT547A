##Clean out my workspace:
outputs <-c("gapminder.csv",
            list.files(pattern = "*.png$"))
file.remove(outputs)

##run my scripts:
source("download.R")
source("hw07_data-analysis.Rmd")
source("hw07_statistics.Rmd")