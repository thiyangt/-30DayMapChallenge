library("rnaturalearth")
library("ggplot2")
library(sf)
library(patchwork)
#data
asia <- ne_countries(continent = "asia",
                          returnclass = "sf")
world <- ne_countries(returnclass = "sf")

#plots
p1 <- ggplot(data=world) + geom_sf() +
  geom_sf(data = asia, fill="#1b9e77")  +
  ggtitle("Van der Grinten projection") +
  coord_sf(crs= "+proj=vandg4")
p1

p2 <- ggplot(data=world) + geom_sf() +
  geom_sf(data = asia, fill="#d95f02")  +
  ggtitle("Robinson projection") +
  coord_sf(crs= "+proj=robin")
p2

p3 <- ggplot(data=world) + geom_sf() +
  geom_sf(data = asia, fill="#7570b3")  +
  ggtitle("Hobo Dyer projection") +
  coord_sf(crs= "+proj=cea +lon_0=0 +lat_ts=37.5 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs")
p3

p4 <- ggplot(data=world) + geom_sf() +
  geom_sf(data = asia, fill="#e7298a")  +
  ggtitle("Gall Peters projection") +
  coord_sf(crs= "+proj=cea +lon_0=0 +x_0=0 +y_0=0 +lat_ts=45 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")
p4

(p1|p2)/(p3|p4) + 
  plot_annotation('Asia Through the Lens of Different Cartographic Projections',
                  caption ='#30DayMapChallenge\nThiyanga S. Talagala')
