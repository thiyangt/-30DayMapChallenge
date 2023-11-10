library(rgdal)
library(rgeos)
library(ggplot2)
library(sf)
library(tidyverse)
library(viridis)


us <- st_read("us_states_hexgrid.geojson")
# Extracting geometry
geometry <- st_geometry(us)
# Extracting latitude and longitude
coordinates <- st_coordinates(geometry)
#head(coordinates)
#tail(coordinates)
lat_lon_df <- data.frame(
  group = coordinates[, "L2"],
  iso3166_2 = us$iso3166_2,
  latitude = coordinates[, "Y"],
  longitude = coordinates[, "X"]
)

#View(lat_lon_df)

us <- us |> select(-geometry) |> as.data.frame()
us <- left_join(us, lat_lon_df, by="iso3166_2")
#View(us)
us <- us |>
  mutate(google_name = gsub(" \\(United States\\)", "", google_name))

#centers
spdf <- readOGR("us_states_hexgrid.geojson")
spdf@data <- spdf@data |>
  mutate(google_name = gsub(" \\(United States\\)", "", google_name))
centers <- cbind.data.frame(data.frame(gCentroid(spdf, byid=TRUE), id=spdf@data$iso3166_2))

# trees
#https://www.gotreequotes.com/states-with-most-forested-acres/#US_Forest_Cover_Map
trees_usa <- read_csv("trees_usa.csv")
#View(trees_usa)
trees_usa <- trees_usa |> rename("google_name" = state)
us <- left_join(us, trees_usa, by="google_name")
#View(us)
#colnames(us)

us <- us |>
  mutate(tree_levels = case_when(trees.per.capita < 10 ~ "1-10",
                                 trees.per.capita >= 10 & trees.per.capita < 50 ~ "10-50",
                                 trees.per.capita >= 50 & trees.per.capita < 500 ~  "50-500",
                                 trees.per.capita >= 500 & trees.per.capita < 1000 ~ "500-1000",
                                 trees.per.capita >= 1000 ~ "≥ 1000"))

us <- us |>
  mutate(forest_levels = case_when(percentage.of.land.forested < 28.8 ~ "0-28.8",
                                   percentage.of.land.forested >= 28.8 & percentage.of.land.forested < 41.8 ~ "28.8-41.72",
                                   percentage.of.land.forested >= 41.72 & percentage.of.land.forested < 42.92 ~  "41.72-42.92",
                                   percentage.of.land.forested >= 42.92 & percentage.of.land.forested < 58.6 ~ "42.92-58.60",
                                   percentage.of.land.forested >= 89.46 ~ "≥ 89.46"))


us <- us |> 
  mutate(across(c(percentage.of.land.forested), 
                ~str_remove(.x, "%") %>% as.numeric())) 
#View(us)
#us <- as.data.frame(us)
us$percentage.of.land.forested <- round(
  us$percentage.of.land.forested, 2)

gg <- ggplot() + 
  #geom_polygon(data = spdf, aes( x = long, y = lat, group = group),fill="white",color="black")+
  geom_polygon(data=us, aes(x = longitude, 
                            y = latitude, 
                            fill=forest_levels, 
                           group=group 
        ))
gg
gg + 
  geom_text(data=us, aes(x=longitude, y=latitude, label=percentage.of.land.forested)) +
  #theme_void() +

  coord_map() +
  labs(x= 'Longitute' , y = 'Latitude',
       title = "Percentage of land forested in the US by states: 2023",
       caption = 'source: https://www.gotreequotes.com/states-with-most-forested-acres/\n#30DayMapChallenge\nThiyanga S. Talagala')


