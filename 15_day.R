#https://ajsmit.github.io/Intro_R_Official/mapping-google.html

lat1 <- 5; lat2 <- 10; lon1 <- 78; lon2 <- 82

library(OpenStreetMap)
library(tidyverse)
library(sp)
library(sf)

worldcities <- read_csv(here::here("cities", "worldcities.csv"))
head(worldcities)
#View(worldcities)

sri_lanaka <- worldcities |>
  filter(iso2=="LK")


sa_map <- openmap(c(lat2, lon1), c(lat1, lon2), zoom = 10,
                  type = "esri-topo", mergeTiles = TRUE)
sa_map2 <- openproj(sa_map)
sa_map2_plt <- OpenStreetMap::autoplot.OpenStreetMap(sa_map2) + 
  geom_point(data = sri_lanaka,
            aes(x = lng + 0.002, y = lat - 0.007), # slightly shift the points
            colour = "red", size =  1, alpha=0.5) +
  xlab("Longitude (°E)") + ylab("Latitude (°S)") +
  labs(title =  "Sri Lanka Cities Available in the World Cities Database",
       caption = '#30DayMapChallenge\nThiyanga S. Talagala') 
sa_map2_plt

