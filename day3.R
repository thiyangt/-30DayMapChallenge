library(denguedatahub)
library(ggplot2)
library(maps)
library(magrittr)
library(viridis)

worlddata2019 <- dplyr::filter(world_annual, year==2019)
ggplot(worlddata2019, aes(x = long,
                          y = lat,
                          group=group,
                          fill = dengue.present)) +
  geom_polygon(color = "black") +
  labs(x = "Longitude",
       y = "Latitude") +
  theme(legend.position = "bottom") + 
  scale_fill_brewer(palette = "Dark2") 
