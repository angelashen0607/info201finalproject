library(shiny)
library(ggplot2)
library(dplyr)
fifa_data <- read.csv("data.csv")
# select the data from midwest dataset
df <- fifa_data %>%
  separate(Wage,c('Wage', 'mark'),sep = 'K') 
fifa_data$Wage <- gsub("€", " ", fifa_data$Wage)
fifa_data$Wage <- paste0(fifa_data$Wage,"000")
fifa_data$Wage <- as.numeric(fifa_data$Wage)

group_age <- fifa_data %>%
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

group_wage <- fifa_data %>%
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


# Define server logic required to draw a plot
shinyServer(function(input, output) {
  
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
      geom_smooth(method = "lm") 
    g
  })
  output$scatter2 <- renderPlot({
    g <- ggplot(data = filtered1(), aes_string(x = "Wage", y = input$ability)) + 
      geom_point() +
      geom_smooth(method = "lm") 
    g
  })
})

