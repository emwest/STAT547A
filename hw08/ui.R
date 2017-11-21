library(shiny)
library(tidyverse)
library(dplyr)
library(DT)


shinyUI(fluidPage(
  #Application title
  titlePanel("BC Liquor Store Refreshment Finder"),
  sidebarLayout(
      sidebarPanel(strong("It's been a long week (or day), let this app do the hard work
               of finding the right refreshments for your evening:"),
                   br(),
               img(src = "wine_glass.jpg", width = "110x"),
               sliderInput("priceInput", "Price Range (CAD)",
                           min = 0, max = 300,value = c(25,40), pre = "$"),
               radioButtons("typeInput", "What kind of beverage?",
                            choices = c("BEER", "SPIRITS", "WINE"),
                            selected = "BEER"),
               uiOutput("countryOutput"),
  hr(),
  span("Data source:", 
       tags$a("OpenDataBC",
              href = "https://www.opendatabc.ca/dataset/bc-liquor-store-product-price-list-current-prices")),
  p(em("Created by Emily West, with code adapted from Dean Attali"))),

  mainPanel(
    h3(textOutput("summaryText")),
    downloadButton("dAtadownload", "Download results", class = NULL),
    br(),
    tabsetPanel(type = "tabs",
                tabPanel("Plot", plotOutput("coolplot")),
                tabPanel("Table", dataTableOutput("results")))
    
    
    )
  )
)
)


