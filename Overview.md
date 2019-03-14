# INFO 201 Final project - Group BA5

## Overview - Major Questions We Seek to Answer

what major questions are you seeking to answer, and what data will you use to answer those questions?

### What Is The Correlation Between Players' Ages and Wages?

*Because it will be hard for the users to read data from all 18,206 players displayed on the graph, we took a sample of the first 1000 players and made correlation plots accordingly.*

We seek to develop a relationship between **the age and selected ability** & **the wages and selected ability.** The dots on both graphs represent the average value of each specific group. For instance, the dot on the age of 20 represents the average overall score (if overall is the selected value) of players who are 20 years old. The lines on both graphs reveal the positive or negative correlation (ordinary least square) between age/wage and the selected values.

**Data Used:**
* Age of the players
* Wage of the players
* Ability of the players
  + Overall
  + Agility
  + Sprint Speed
  + Shot Power
  + Stamina
  + Aggression
  + Positioning
  + Finishing


### Where Are Most Players From and How Are Their Skills?
We plan to provide **demographic information** for the coaches so it is easier for them to **understand a player's background**. Every dot on the map includes a player's photo, name, nationality, wage, value, club, and one selected value. With this information, the coach can easily search for players with from a specific region and check for a specific selected ability.

**Data Used:**
* Location of the players
* Name of the players
* Nationality of the players
* Wage of the players
* Value of the players
* Clubs that players belong to
* Ability of the players
  + Crossing
  + Finishing
  + Head Accuracy
  + Short Passing
  + Dribbling
  + Volleys
  + Curve
  + Long Passing
  + Ball Control
  + Acceleration
  + Sprint Speed
  + Agility
  + Reactions
  + Balance
  + Shot Power
  + Stamina
  + Strength


### What Are the Price-Performance Ratio For Each Player In Different Club?

*Because there are players who have high overall score but low value, we measure the price-performance ratio by dividing the overall score by the players' values. (which gives an information of the score per EUR of players) We define the most valuable player as the player with higher price-performance ratio.*

We plan to provide coach information about each player's **price-performance ratio in the selected club.** With the graph provided, the coach will be able to find the most valuable player in the selected club with selected skills.
