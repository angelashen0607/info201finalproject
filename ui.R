library(shiny)
library(leaflet)
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


age_range <- range(group_age[1])
wage_range <- range(group_wage[1])
#extract the column by specifying an index
select_values1 <- colnames(group_age[2:9])
shinyUI(fluidPage(
  includeCSS("styles.css"),
  navbarPage("FIFA Data Exploration", 
             tabPanel("Overview",
                mainPanel(
                  tags$h1("Overview of FIFA Player Exploration"),
                  tags$h3("What Is The Correlation Between Players' Ages 
                          and Wages?"),
                  tags$em("Because it will be hard for the users to read data 
                          from all 18,206 players displayed on the graph, we 
                          took a sample of the first 1000 players and made 
                          correlation plots accordingly."),
                  tags$br(),
                  tags$br(),
                  tags$body("We seek to develop a relationship between the age 
                          and selected ability & the wages and selected ability.
                          The dots on both graphs represent the average value of
                          each specific group. For instance, the dot on the age 
                          of 20 represents the average overall score 
                          (if overall score is the selected value) of players 
                          who are 20 years old. The lines on both graphs reveal 
                          the positive or negative correlation 
                          (ordinary least square) between age/wage and the 
                          selected values."),
                  tags$h4("Data Used:"),
                  tags$ul(
                    tags$li("Age of the players"), 
                    tags$li("Wage of the players"), 
                    tags$li("Ability of the players"),
                    tags$li("Overall Score"),
                    tags$li("Agility"),
                    tags$li("Sprint Speed"),
                    tags$li("Shot Power"),
                    tags$li("Stamina"),
                    tags$li("Aggression"),
                    tags$li("Positioning"),
                    tags$li("Finishing")
                  ),
                  tags$h3("Where Are Most Players From and How Are 
                          Their Skills?"),
                  tags$body("We plan to provide demographic information for the
                            coaches so it is easier for them to understand a 
                            player's background. Every dot on the map includes a
                            player's photo, name, nationality, wage, value, 
                            club, and one selected value. With this information,
                            the coach can easily search for players with from a
                            specific region and check for a specific selected 
                            ability."),
                  tags$h4("Data Used:"),
                  tags$ul(
                    tags$li("Location of the players"), 
                    tags$li("Name of the players"), 
                    tags$li("Nationality of the players"),
                    tags$li("Wage of the players"),
                    tags$li("Value of the players"),
                    tags$li("Clubs that players belong to"),
                    tags$li("Ability of the players"),
                    tags$li("Crossing"),
                    tags$li("Finishing"),
                    tags$li("Head Accuracy"),
                    tags$li("Short Passing"),
                    tags$li("Dribbling"),
                    tags$li("Volleys"),
                    tags$li("Curve"),
                    tags$li("Long Passing"),
                    tags$li("Ball Control"),
                    tags$li("Acceleration"),
                    tags$li("Sprint Speed"),
                    tags$li("Agility"),
                    tags$li("Reactions"),
                    tags$li("Balance"),
                    tags$li("Shot Power"),
                    tags$li("Stamina"),
                    tags$li("Strength")
                  ),
                  tags$h3("What Are the Price-Performance Ratio For Each Player
                          In Different Club?"),
                  tags$em("Because there are players who have high overall score
                          but low value, we measure the price-performance ratio
                          by dividing the overall score by the players' values. 
                          (which gives an information of the score per EUR of 
                          players) We define the most valuable player as the 
                          player with higher price-performance ratio."),
                  tags$br(),
                  tags$br(),
                  tags$body("We plan to provide coach information about each 
                            player's price-performance ratio in the selected 
                            club. With the graph provided, the coach will be 
                            able to find the most valuable player in the 
                            selected club with selected skills."),
                  tags$h4("Data Used:"),
                  tags$ul(
                    tags$li("Clubs that players belong to"), 
                    tags$li("Overall score of the players"), 
                    tags$li("Value of the players"),
                    tags$li("Ability of the players"),
                    tags$li("Agility"),
                    tags$li("Sprint Speed"),
                    tags$li("Shot Power"),
                    tags$li("Stamina"),
                    tags$li("Aggression"),
                    tags$li("Positioning"),
                    tags$li("Finishing")
                  )
                )
             ),
             tabPanel("Demographics", 
                      sidebarLayout(
                        
                        sidebarPanel(
                          selectInput(
                            "color", 
                            label = "Player Stats", 
                            choices = list(
                              "Crossing" = "Crossing", 
                              "Finishing" = "Finishing", 
                              "Heading Accuracy" = "HeadingAccuracy", 
                              "Short Passing" = "ShortPassing", 
                              "Volleys" = "Volleys", 
                              "Dribbling" = "Dribbling", 
                              "Curve" = "Curve", 
                              "Long Passing" = "LongPassing",
                              "Ball Control" = "BallControl", 
                              "Acceleration" = "Acceleration", 
                              "Sprint Speed" = "SpringSpeed", 
                              "Agility" = "Agility", 
                              "Reactions" = "Reactions", 
                              "Balence" = "Balence", 
                              "Shot Power" = "ShotPower", 
                              "Stamina" = "Stamina", 
                              "Strength" = "Strength"
                            ), 
                            selected = "displ"
                          )
                        ),
                        mainPanel(
                          leafletOutput("world_map")
                        )
                      )
             ),
             tabPanel(
               "Correlation plot",
               
               # Add a titlePanel to your tab
               titlePanel("Correlation Between Age/Wage and Ability"),
               
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
             ),
             tabPanel(
               "Club Value", 
               sidebarLayout(
                 sidebarPanel(
                   selectInput("Club","Please Select A Club",
                               label = h3 ("Select a Club"),
                               choices = list("FC Barcelona", "Juventus","Paris Saint-Germain", 
                                              "Manchester United", "Real Madrid", "Atlético Madrid", 
                                              "Manchester City", "FC Bayern München"))
                 ),
                 # Show a plot of the generated distribution
                 mainPanel(
                   plotOutput("select_targets")
                 )
               )  
             )
  )
))