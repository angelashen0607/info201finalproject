library(shiny)
library(dplyr)
library(leaflet)
library(ggplot2)
library(tidyr)

fifa_data <- read.csv("data.csv")
df <- fifa_data %>%
  separate(Wage,c('Wage', 'mark'),sep = 'K') 
df$Wage <- gsub("€", " ", df$Wage)
df$Wage <- paste0(df$Wage,"000")
df$Wage <- as.numeric(df$Wage)

group_age <- df %>%
  sample_n(1000) %>%
  group_by(Age) %>%
  select(Age, Overall, Agility, SprintSpeed, ShotPower, Stamina, Aggression, Positioning, Finishing) %>%
  summarise(Overall = mean(Overall),
            Agility = mean(Agility),
            SprintSpeed = mean(SprintSpeed),
            ShotPower = mean(ShotPower),
            Stamina = mean(Stamina),
            Aggression = mean(Aggression),
            Positioning = mean(Positioning),
            Finishing = mean(Finishing),na.rm = T)

group_wage <- df %>%
  sample_n(1900) %>%
  group_by(Wage) %>%
  select(Wage, Overall, Agility, SprintSpeed, ShotPower, Stamina, Aggression, Positioning, Finishing) %>%
  summarise(Overall = mean(Overall),
            Agility = mean(Agility),
            SprintSpeed = mean(SprintSpeed),
            ShotPower = mean(ShotPower),
            Stamina = mean(Stamina),
            Aggression = mean(Aggression),
            Positioning = mean(Positioning),
            Finishing = mean(Finishing),na.rm = T)

server <- function(input, output) {
  
  output$world_map <- renderLeaflet({
    leaflet(data = fifa_data) %>% 
      addProviderTiles(providers$CartoDB.Positron) %>% 
      addCircleMarkers(
        lat = ~lat, 
        lng = ~long,
        popup = paste0(
          paste0("<img src = ", fifa_data$Photo, ">"),"<br>", 
          "Name: ", fifa_data$Name, "<br>",
          "Nationality: ", fifa_data$Nationality, "<br>",
          "Wage: ", fifa_data$Wage, "<br>",
          "Value: ", fifa_data$Value, "<br>",
          "Club: ", fifa_data$Club, "<br>",
          input$color, ": ", fifa_data[, input$color]
        ),
        color = "black", 
        radius = 5,
        stroke = FALSE
      )
  })
  filtered <- reactive({
    data <- group_age %>%
      filter(Age > input$age[1], Age < input$age[2]) 
    data # return data
  })
  filtered1 <- reactive({
    data1 <- group_wage %>%
      filter(Wage > input$wage[1], Wage < input$wage[2]) 
    data1 # return data
  })
  
  output$scatter1 <- renderPlot({
    g <- ggplot(data = filtered(), aes_string(x = "Age", y = input$ability)) + 
      geom_point() +
      geom_smooth(method = "lm",se = F) 
    g
  })
  output$scatter2 <- renderPlot({
    g <- ggplot(data = filtered1(), aes_string(x = "Wage", y = input$ability)) + 
      geom_point() +
      geom_smooth(method = "lm",se=F) 
    g
  })
  
}