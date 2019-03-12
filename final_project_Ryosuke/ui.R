library(shiny)
library(ggplot2)
library(dplyr) 
library(tidyr)
fifa_data <- read.csv("data.csv")
# select the data from midwest dataset
df <- fifa_data %>%
  separate(Wage,c('Wage', 'mark'),sep = 'K') 
df$Wage <- gsub("€", " ", df$Wage)
df$Wage <- paste0(df$Wage,"000")
df$Wage <- as.numeric(df$Wage)

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


age_range <- range(group_age[1])
wage_range <- range(group_wage[1])
#extract the column by specifying an index
select_values1 <- colnames(group_age[2:9])
# Define UI for application that draws a plot
shinyUI(navbarPage(
  "Midwest Dataset",
  
  # Application title
  tabPanel(
    "Scatter1",
    
    # Add a titlePanel to your tab
    titlePanel("correlation between age and ability"),
    
    sliderInput(
      "age",
      label = "Age of players",
      min = age_range[1],
      max = age_range[2],
      value = age_range
    ),
    sliderInput(
      "wage",
      label = "Wage of players(€)",
      min = wage_range[1],
      max = wage_range[2],
      value = wage_range
    ),
    # Create a sidebar layout for this tab 
    # Create a sidebarPanel 
    selectInput(
      "ability",
      label = "ability of players",
      choices = select_values1
    ),
    
    # Create a main panel
    mainPanel(
      plotOutput("scatter1"),
      plotOutput("scatter2")
    )
  )
)
)



