# INFO 201 Final project - Group BA5

## Project Description
- **General data set information:**
The dataset that we are using is “FIFA 19 complete player dataset” extracted from [Kaggle](https://www.kaggle.com/karangadiya/fifa19/version/4). The dataset includes detailed attributes for every player registered in the latest edition of FIFA 19 database and was posted by Karan Gadiysa, a student at University of Virginia. The data was gathered from https://sofifa.com/.

- **Target Audience:**
There are a wide variety of audiences who might interact with this dataset, ranging from players, coaches, fans, sponsorships, to advertisement companies. However, our targeted audience for this project is going to be focused on the coaches. The coaches will be able to use this datset to pick out the most valued players with the most potential for their teams in forming stronger teams.

- **Three or more questions the data will answer:**
  1. Who is the most valuable goalkeeper?
  2. What are the correlation between overall score and the value?
  3. What is the average age of the soccer players?
  4. What is the average height of the soccer players?
  5. What are the standard deviations of values/wages?

## Technical Description
- **Reading in data:** 
We will be reading the data in as a .csv file.
 
- **Types of data wrangling:**
We would probably need to subset the dataset and group the elements according to the choice of selections. In addition, we would also have to filter out the data according to the user's selections. By using `dplyr`, we select/mutate/fiter the dataset.
 
- **New libraries to be used:**
We plan to use `plotly`,`ggplot`.`shiny`,`tidyverse` and so on.
 
- **Some challenges we anticipate are:**
  1. We all have a general understanding of the FIFA data set; however, we do not possess significant expertise on the domain. Analyzing and Interpreting findings may require additional research.
  2. The ability to be flexible and consider the context in the short amount of time we have to work on this project. Communication and clear collaboration efforts will be key.
  3. Running into debugging errors that take more time to resolve than we had originally planned to allot. Especially if we envision aspects of a page that we have not yet learned about in class, incorporating ideas from the internet can be more challenging.
    
- **Questions to answer with statistical analysis:**
  1. Mean age of the players - oldest player, youngest players.
  2. Most valuable goalkeeper based on given score.
  3. Which players get paid the most?
  4. Average height of players in each position.
  5. Which nation has the most players?
  6. Which players have been playing the longest?
  7. Average potential of players in each nation.
  
