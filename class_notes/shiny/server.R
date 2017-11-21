library(shiny)
library(tidyverse)
library(dplyr)
library(DT)


bcl<-read.csv("bcl_data.csv")

shinyServer(function(input, output) {
  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })
  
#filter beverage by price using slider from ui
  filtered <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    }    
    
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      ) 
  })
  
#generate a plot based on user input of alcohol type and choice  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content, fill = Type)) +
      geom_histogram()+labs(x= "Alcohol Content", y = "Number of selections")
  })
#Create a sweet output table using DT
  output$results <- renderDataTable({
    filtered()
  })
  
  output$dAtadownload <- downloadHandler(
    filename = "bcl-results.csv",
    content = function(con) {
      write.csv(filtered(), con)
    }
  )
  output$summaryText <- renderText({
    numOptions <- nrow(filtered())
    if (is.null(numOptions)) {
      numOptions <- 0
    }
    paste0("We found ", numOptions, " options for you")
  })
  
})
