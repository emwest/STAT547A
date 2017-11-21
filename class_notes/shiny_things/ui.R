# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("My Alcohol Webpage"),
  
  sidebarPanel("This is the sidebar"),
  
  mainPanel(plotOutput("Histo_AlcCont"))

  )
  

