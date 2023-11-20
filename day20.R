
library(rnaturalearth)
library(sf)
library(ggplot2)
library(sp)
library(maps)
library(OpenStreetMap)
library(tidyverse)
install.packages(c("rgdal", "sf"))
library(rgdal)


lon1 <- -113
lon2 <- -110
lat1 <- 35
lat2 <- 37

sa_map <- openmap(c(lat2, lon1), c(lat1, lon2),
                  type = "esri-topo", mergeTiles = TRUE)
sa_map2 <- openproj(sa_map)
sa_map2_plt <- OpenStreetMap::autoplot.OpenStreetMap(sa_map2)
sa_map2_plt
