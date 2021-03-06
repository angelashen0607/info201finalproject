library(shiny)
library(dplyr)
library(leaflet)
library(ggplot2)
library(tidyr)

#read the data from our directory
fifa_data <- read.csv("data.csv")

#make the column of wage as numeric
df <- fifa_data %>%
  separate(Wage,c('Wage', 'mark'),sep = 'K') 
df$Wage <- gsub("€", " ", df$Wage)
df$Wage <- paste0(df$Wage,"000")
df$Wage <- as.numeric(df$Wage)

#extract the 1000 samples and calicurate the mean of each component based on age
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

#extract the 1900 samples and calicurate the mean of each components based on the wage
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
  
  #Makes world map for displaying where players are from
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
        stroke = FALSE, 
        opacity = fifa_data[, input$color] / 100
      )
  })
  
  # Filters data and makes graphical representations for corrleational data
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
    
  #Created graphical representation for club specific data
  output$select_targets <- renderPlot({
    unit_value <- group_by(fifa_data, Overall,Value)
    unit_value <- fifa_data %>% filter(Club == input$Club)
      
   summary <- unit_value %>%
      select(Value, Overall)
    ggplot(summary, aes(x=Value, y=Overall)) +
      geom_boxplot(size=1, fill="yellow")
    
  })
}