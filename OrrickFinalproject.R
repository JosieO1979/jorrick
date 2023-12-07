# Load necessary libraries
library(shiny)
library(dplyr)

# Load the dataset
# Replace 'path_to_your_file' with the actual path to your dataset
data <- KansasCrimeLongedit

# Define UI for the application
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

# Define server logic
server <- function(input, output) {
  output$crimeRateOutput <- renderText({
    filtered_data <- filter(data, County == input$county, Year == input$year)
    crime_rate <- filtered_data$`Crime Rate`
    paste("Crime rate for", input$county, "in", input$year, "is", crime_rate)
  })
}

# Run the application
shinyApp(ui = ui, server = server)

