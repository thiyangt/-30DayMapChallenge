library(magick)
i <- image_read("day11.png")
i %>% image_convert(type = 'Bilevel')
