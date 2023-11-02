origin_city<-rep('Melbourne Airport, VIC, Australia', 4)
destination_city<- c('Cairns, QLD, Australia', 'Brisbane Airport, QLD, Australia', 'Sydney Airport, NSW, Australia',
                     'Adelaide Airport ')
o_lat <- rep(-37.663712, 4)
o_long<- rep(144.844788, 4)
d_lat<-c(-16.876730, -27.383333, -33.947346, -34.946156)
d_long<-c(145.754135, 153.118332, 151.179428, 138.533238)
size <- c(1, 5, 5, 1)

df<-data.frame(origin_city,destination_city,o_lat,
               o_long,d_lat,d_long, size)

library(ozmaps)
library(sf)
oz_states <- ozmaps::ozmap_states
g <- ggplot(oz_states) + 
  geom_sf() + 
  coord_sf()

g + geom_curve(data=df, aes(x = o_long, 
                            y = o_lat, 
                            xend = d_long, yend = d_lat, size = size),
                   col = "red", curvature = .2) +
  geom_point(data=df, aes(x = d_long, y = d_lat), col = "black") +
  geom_point(data=df, aes(x = o_long, y = o_lat), col = "black") +
  ggrepel::geom_text_repel (data=df, aes(x = d_long,y = d_lat, label = destination_city), col = "black") +
  theme(legend.position = "none") + xlab("latitude")+
  ylab("longitude")
