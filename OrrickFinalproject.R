
library(shiny)
library(dplyr)

data <- KansasCrimeLongedit

ui <- fluidPage(
  titlePanel("Kansas County Crime Rates"),
  sidebarLayout(
    sidebarPanel(
      selectInput("county", "Select County:", choices = unique(data$County)),
      sliderInput("year", "Select Year:", min = 2012, max = 2017, value = 2012, step = 1)
    ),
    mainPanel(
      textOutput("crimeRateOutput")
    )
  )
)

server <- function(input, output) {
  output$crimeRateOutput <- renderText({
    filtered_data <- filter(data, County == input$county, Year == input$year)
    crime_rate <- filtered_data$`Crime Rate`
    paste("Crime rate for", input$county, "in", input$year, "is", crime_rate)
  })
}

shinyApp(ui = ui, server = server)

