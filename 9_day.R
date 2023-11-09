# packages
library(tidyverse)
library(rgeos)
library(geojsonio)
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

library(maps) # For map data
# Get map data for USA
states_map <- map_data("state") 
View(states_map)
spdf_tidy <- tidy(spdf)
View(spdf_tidy)



# Show it
ggplot() +
  geom_polygon(data = spdf, aes( x = long, y = lat, group = group),fill="white",  color="black") +
  geom_text(data=centers, aes(x=x, y=y, label=id)) +
  #theme_void() +
  coord_map() +
  labs(x= 'Longitute' , y = 'Latitude',
       title = "Hexbin representation of the US",
       caption = '#30DayMapChallenge\nThiyanga S. Talagala')
