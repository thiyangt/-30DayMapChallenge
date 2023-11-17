library(maps)
library(OpenStreetMap)
library(tidyverse)
library(sp)
library(sf)


df <- world.cities[world.cities$country.etc == "Australia",]
View(df)

lat1 <- -60; lat2 <- 0; lon1 <- 100; lon2 <- 160
sa_map <- openmap(c(lat2, lon1), c(lat1, lon2),
                  type = "esri-topo", mergeTiles = TRUE)
sa_map2 <- openproj(sa_map)
sa_map2_plt <- OpenStreetMap::autoplot.OpenStreetMap(sa_map2) + 
  geom_point(data = df,
             aes(x = long , y = lat), # slightly shift the points
             colour = "red", size =  1, alpha=0.5) +
  xlab("Longitude (°E)") + ylab("Latitude (°S)") +
  labs(title =  "Main Cities",
       caption = '#30DayMapChallenge\nThiyanga S. Talagala') 
sa_map2_plt
