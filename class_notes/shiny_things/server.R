library(shiny)
library(tidyverse)
# Define server logic required to draw a histogram

server <- function(input, output) {
  bcl_data <-read_csv("~/Desktop/UBC_Work/STAT545/shiny_things/bcl-data.csv")
  output$Histo_AlcCont <- renderPlot({
    bcl_data %>% 
      ggplot() + aes(x = Alcohol_Content) + geom_histogram()
  })
  
}
