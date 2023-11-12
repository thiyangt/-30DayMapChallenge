# Load useful packages
library(sf)
library(marmap)
library(tidyverse)
library(rnaturalearth)
library(viridis)

# Get bathymetric data
bat <- getNOAA.bathy(-90, -30, 20,-80, res = 4, keep = TRUE)
bat_xyz <- as.xyz(bat)

# Import country data
country <- ne_countries(scale = "medium", returnclass = "sf")

# Plot using ggplot and sf
ggplot() + 
  geom_sf(data = country) +
  geom_tile(data = bat_xyz, aes(x = V1, y = V2, fill = V3)) +
  scale_fill_viridis() +
  coord_sf() +
  labs(x = "Longitude", y = "Latitude", fill = "Depth (m)",
       title = "Bathymetric Data Visualization Around South America",
       caption = '#30DayMapChallenge\nThiyanga S. Talagala') +
  theme_minimal()

