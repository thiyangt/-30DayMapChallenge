#https://www.gdpradvisor.co.uk/gdpr-countries
library(sf)
library(rnaturalearth)
library(tidyverse)
worldmap <- ne_countries(scale = 'medium', type = 'map_units',
                         returnclass = 'sf')
nonGDPR <- c("Albania",
"Belarus",
"Bosnia and Herzegovina",
"Kosovo",
"Moldovia",
"Montenegro",
"North Macedonia",
"Russia",
"Serbia",
"Turkey",
"Ukraine")
worldmap$nongdpr <- worldmap$sovereignt %in% nonGDPR
worldmap$nongdpr <- factor(worldmap$nongdpr, 
                 levels=c(FALSE, TRUE), 
                 labels=c("Yes","No"))

europe_cropped <- st_crop(worldmap, xmin = -20, xmax = 45,
                          ymin = 30, ymax = 73)
ggplot() + 
  geom_sf(data = europe_cropped, aes(fill=nongdpr)) + 
  scale_fill_discrete(name = "Has GDPR been implemented?") +
  theme(legend.position="top") + 
  labs(title =  "GDPR and Non-GDPR European Countries",
       caption = '#30DayMapChallenge\nThiyanga S. Talagala\ndata: https://www.gdpradvisor.co.uk/gdpr-countries')
