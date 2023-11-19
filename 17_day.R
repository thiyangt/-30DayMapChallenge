#https://blog.benthies.de/blog/mapping-streams-and-rivers-with-ggplot-sf/
# Packages
library(dplyr) # Data manipulation
library(ggplot2) # Plotting
library(sf) # Geometric operations
library(ceylon)
library(sp)

# Sri Lanka Rivers and Streams
#https://data.humdata.org/dataset/sri-lanka-water-bodies-0-0?#
unzip("lka_rapidsl_rvr_250k_sdlka.zip")
rivers <- st_read("lka_rapidsl_rvr_250k_sdlka.shp")
saveRDS(rivers, "rivers.rds")


data(sf_sl_0)

g <- ggplot(data = sf_sl_0) +
  geom_sf(fill="#edf8b1", color="#AAAAAA") +
  geom_sf(data=rivers, colour="#253494") +
  labs(title =  "Sri Lanka Rivers and Streams",
       caption = '#30DayMapChallenge\nThiyanga S. Talagala\ndata:https://data.humdata.org/dataset/sri-lanka-water-bodies-0-0?#') 
g



