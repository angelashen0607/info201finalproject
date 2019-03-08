# Geocode addresses: based on the following blog post
# http://www.storybench.org/geocode-csv-addresses-r/
# NO NEED to run this script -- it is only included in case you are 
# curious how the lat/long were computed using the address

# Use dev version of ggmaps so that you can set the Google Maps API key
# devtools::install_github("dkahle/ggmap")
library(ggmap)
library(dplyr)

# Load and google maps API key (you'll need to get your own to run the script)
source("api-key.R")
register_google(key = google_key)

# Load the raw data
library(ggmap)
raw_data <- read.csv("data.csv", stringsAsFactors = FALSE) %>%
  mutate(
    lat = 0,
    long = 0, 
    city_state = Nationality
  )

# Get addresses using the geocode function
raw_data[, c("long", "lat")] <- geocode(raw_data$city_state)

# Write a CSV file containing raw_data to the working directory
write.csv(raw_data, "data.csv", row.names = FALSE)