library(shiny)
library(leaflet)

shinyUI(fluidPage(
  navbarPage("FIFA Data Exploration", 
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
    )
  )
))