

library(tidygeocoder)
df <- tidygeocoder::geocode(df, address = addr, method = "osm")
library(ggmap)
#https://springernature.figshare.com/articles/dataset/Hospital_IDs_names_and_coordinates_csv_/8319737
# subset the data
library(tidyverse)
location <- read_csv(here::here("myhospitals-contact-details.csv"))
head(location)
location <- location |> 
  filter(Suburb == "Melbourne")

library(mapview)
library(sf)
mymap <- st_as_sf(location, coords = c("Longitude", "Latitude"), crs = 4326)
mapview(mymap, color="black", col.regions="red",
        alpha.regions=0.5, legend = FALSE,
        homebutton = FALSE, map.types = "OpenStreetMap" )

