library(rgdal)
library(rgeos)
library(ggplot2)
library(sf)
library(tidyverse)

#us <- st_read("us_states_hexgrid.geojson")
us <- readOGR("us_states_hexgrid.geojson")
us@data <- us@data |>
  mutate(google_name = gsub(" \\(United States\\)", "", google_name))

usfortify <- st_centroid(us)
usfortify <- usfortify |>
  mutate(google_name = gsub(" \\(United States\\)", "", google_name))
View(usfortify)
usfortify <- usfortify |> extract(geometry, c('lat', 'lon'), '\\((.*), (.*)\\)', convert = TRUE) 
view(usfortify)
#centers$id <- us$iso3166_2
centers <- cbind.data.frame(data.frame(gCentroid(us, byid=TRUE), id=us@data$iso3166_2))

# trees
#https://www.gotreequotes.com/states-with-most-forested-acres/#US_Forest_Cover_Map
trees_usa <- read_csv("trees_usa.csv")
View(trees_usa)
trees_usa <- trees_usa |> rename("google_name" = state)
usfortify <- left_join(usfortify, trees_usa, by = "google_name")
usfortify <- left_join( us@data,usfortify, by = "google_name")
View(usfortify)
gg <- ggplot() + 
  geom_polygon(data = usfortify, aes( x = lon, y = lat,group=label.y)) 
gg <- gg + geom_text(data=centers, aes(label=id), color="white", size=4)
gg
gg <- gg + scale_fill_distiller(palette="RdPu", na.value="#7f7f7f")
gg <- gg + coord_sf()
gg <- gg + labs(x=NULL, y=NULL)
gg <- gg + theme_bw()
gg <- gg + theme(panel.border=element_blank())
gg <- gg + theme(panel.grid=element_blank())
gg <- gg + theme(axis.ticks=element_blank())
gg <- gg + theme(axis.text=element_blank())

print(gg)
