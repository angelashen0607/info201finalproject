library(shiny)
library(dplyr)
library(leaflet)

server <- function(input, output) {
  
  fifa_data <- read.csv("data.csv", stringsAsFactors = FALSE)
      
  output$world_map <- renderLeaflet({
    leaflet(data = fifa_data) %>% 
      addProviderTiles(providers$CartoDB.Positron) %>% 
      addCircleMarkers(
        lat = ~lat, 
        lng =~long,
        popup = paste0(
          paste0("<img src = ", fifa_data$Photo, ">"),"<br>", 
          "Name: ", fifa_data$Name, "<br>",
          "Nationality: ", fifa_data$Nationality, "<br>",
          "Wage: ", fifa_data$Wage, "<br>",
          "Value: ", fifa_data$Value, "<br>",
          "Club: ", fifa_data$Club, "<br>"
        ),
        color = input$color, 
        radius = 5
      )
  })
  
}