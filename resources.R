#https://rspatialdata.github.io/osm.html
#https://www.paulamoraga.com/tutorial-open-spatial-data/
install.packages("osmdata")
library(osmdata)

library(httr)
set_config(config(ssl_verifypeer = 0L))
#Error:                             
#  ! Peer certificate cannot be authenticated with given CA certificates: [nominatim.openstreetmap.org] SSL certificate problem: certificate has expired
#Run `rlang::last_trace()` to see where the error occurred.

ocenia_bb <- getbb("Ocenia")
ocenia_bb

# https://fedir.gontsa.com/portfolio/my-30daymapchallenge-2020