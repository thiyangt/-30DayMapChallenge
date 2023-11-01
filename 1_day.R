## packages
library(tidyverse)
library(ceylon)
library(sp)
library(viridis)
library(sf)

## data
# source
# https://simplemaps.com/data/world-cities
worldcities <- read_csv(here::here("cities", "worldcities.csv"))
head(worldcities)
#View(worldcities)

sri_lanaka <- worldcities |>
  filter(iso2=="LK")
#View(sri_lanaka)

sri_lanaka  <- sri_lanaka %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  st_transform(crs = st_crs(district))

#plot

ggplot(district) + 
  geom_sf() +
  geom_sf(data = sri_lanaka ,
          size = 2,
          col = "darkred",
          alpha=0.5) + 
         labs(title ="Sri Lanka Cities Available in the World Cities Database",
              caption = "Source: https://simplemaps.com/data/world-cities")
