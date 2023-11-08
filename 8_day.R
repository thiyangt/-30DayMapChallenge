library(tidyverse)
#https://afrimapr.github.io/afrilearndata/
# install.packages("remotes") # if not already installed
remotes::install_github("afrimapr/afrilearndata")
library(afrilearndata)


data(afripop2020)
africa_2020 <- afripop2020 |>
  as.data.frame(xy=TRUE) |>
  rename("Pop" = "ppp_2020_1km_Aggregated") |> 
  filter(!is.na(Pop))
africa_2020 <- africa_2020 |>
  mutate(Pop_Levels = case_when(Pop < 1 ~ "0",
                                Pop > 0 & Pop < 10 ~ "1-10",
                                Pop >= 10 & Pop < 25 ~  "10-25",
                                Pop >= 25 & Pop < 75 ~ "25-75",
                                Pop >= 75 ~ "≥ 75")) 



head(africa_2020)



africa_2020 |>
  ggplot(aes(x=x, y=y, fill = Pop_Levels |> fct_reorder(Pop), color=Pop_Levels |> fct_reorder(Pop))) +  
  geom_tile() +
  scale_fill_manual(values = viridis::turbo(n=5),  name = NULL) +
  scale_color_manual(values = viridis::turbo(n=5), name = NULL) +
  xlab("latittude") + ylab("longitude") + 
  ggtitle(" Population density 2020 from WorldPop* aggregated to 20km squares") +
  labs(caption = ("afrilearndata package in R\nWorldPop: https://www.worldpop.org/\n#30DayMapChallenge\nThiyanga S. Talagala"))

