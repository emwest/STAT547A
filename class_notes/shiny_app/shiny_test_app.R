library(shiny)
library(stringr)

my_ui <- fluidPage(
  h1("This is a very nice website!"),
  h2("this is a subititle"),
  "This is the body of my website",
  textInput("My_Text_In", "Enter some text here"),
  "This is my output text",
  br(),
  textOutput("Yo_text")
)

my_server <- function(input, output){
  output$Yo_text <- renderText({
    str_to_upper(input$My_Text_In) 
  })
}

shinyApp(ui = my_ui, server = my_server)
