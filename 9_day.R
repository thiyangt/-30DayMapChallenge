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
head(spdf@data)
