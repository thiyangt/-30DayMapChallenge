# packages
library(tidyverse)
library(rvest)
library(broom)
library(rgeos)
library(geojsonio)
library(here)
library(sf)
library(rgdal)
library(rgeos)
library(sp)
#install.packages("remotes")
#remotes::install_github("ropensci/geojsonio")

# data
#https://www.gotreequotes.com/states-with-most-forested-acres/#US_Forest_Cover_Map
trees_usa <- read_csv("trees_usa.csv")
View(trees_usa)

## map
#https://www.rpubs.com/ishaque007/744287
spdf <- readOGR("us_states_hexgrid.geojson")
spdf@data <- spdf@data |>
  mutate(google_name = gsub(" \\(United States\\)", "", google_name))

centers <- cbind.data.frame(data.frame(gCentroid(spdf, byid=TRUE), id=spdf@data$iso3166_2))

spdf_fortified <- tidy(spdf)
View(spdf_fortified)

spdf_trees <- left_join(spdf@data, trees_usa)
View(spdf_trees)

# Show it
ggplot() +
  geom_polygon(data = spdf_fortified, aes( x = long, y = lat, group = group),  color="white") +
  geom_text(data=centers.new, aes(x=x, y=y, label=id)) +
  theme_void() +
  coord_map() +
  labs(x= 'Longitute' , y = 'Latitude',
       title = "Percentage of Forest Acres by States in the US",
       caption = 'Source: https://www.gotreequotes.com/states-with-most-forested-acres/#US_Forest_Cover_Map\n#30DayMapChallenge\nThiyanga S. Talagala')
