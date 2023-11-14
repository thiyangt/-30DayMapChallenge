library(ceylon)
library(ggplot2)
library(viridis)

#data population
# https://lankastatistics.com/economic/districtwise-population-and-density.html
data(district)
ggplot(district) + 
  geom_sf(aes(fill = population), show.legend = TRUE) +  
  scale_fill_viridis(option="H") + 
   ggtitle("Estimated Population in Sri Lanka - 2020")
