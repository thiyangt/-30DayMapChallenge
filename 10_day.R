# Load useful packages
library(sf)
library(marmap)
library(tidyverse)
library(rnaturalearth)
library(viridis)

# Get bathymetric data
bat <- getNOAA.bathy(-170, -50, 0,80, res = 4, keep = TRUE)
bat_xyz <- as.xyz(bat)

# Import country data
country <- ne_countries(scale = "medium", returnclass = "sf")

# Plot using ggplot and sf
ggplot() + 
  geom_sf(data = country) +
  geom_tile(data = bat_xyz, aes(x = V1, y = V2, fill = V3)) +
  geom_contour(data = bat_xyz, 
               aes(x = V1, y = V2, z = V3),
               binwidth = 100, color = "grey85", size = 0.1) +
  geom_contour(data = bat_xyz, 
               aes(x = V1, y = V2, z = V3),
               breaks = -200, color = "grey85", size = 0.5) +
  geom_sf(data = country) +
  scale_fill_viridis() +
  coord_sf(xlim = c(-170, -50), 
           ylim = c(0, 80)) +
  labs(x = "Longitude", y = "Latitude", fill = "Depth (m)",
       title = "Bathymetric Data Visualization\nAround North America",
       caption = '#30DayMapChallenge\nThiyanga S. Talagala') +
  theme_minimal()

