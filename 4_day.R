# https://worldhappiness.report/ed/2023/#appendices-and-data
# report
# https://happiness-report.s3.amazonaws.com/2023/WHR+23.pdf
## packages
library(tidyverse)
library(here)
library(maps)
library(viridis)


## data
# https://worldhappiness.report/ed/2023/world-happiness-trust-and-social-connections-in-times-of-crisis/
#  https://happiness-report.s3.amazonaws.com/2023/WHR+23.pdf
#page 43
happines <- read_csv(here("day3", "happines.csv"))
View(happines)
## map

# Inequality of happiness
# Size of the happiness gap between the 
# top and bottom halves of each country's population
#( A higher gap means higher happiness inequality.)

#the gap has amaximum value of 10 and a minimum of zero
hcountry <- unique(happines$Country)
world_coordinates <- map_data("world") 
#head(world_coordinates)
wcountry <- unique(world_coordinates$region)
sort(wcountry[!(wcountry %in% hcountry)])
hcountry[!(hcountry %in% wcountry)]


happines <- happines |> 
  mutate(Country2 = recode(Country, "Tajikistan*" = "Tajikistan"  ,
                           "United Kingdom" = "UK",
                           #"Hong Kong S.A.R."=,
                           "Algeria*" = "Algeria",
                           "Taiwan Province of China" = "Taiwan",
                           "United States" = "USA",
                           "Czechia" = "Czech Republic",
                           "Slovakia" = "Slovakia",
                           "Korea, Republic of" = "South Korea",
                           "Congo, Republic of" = "Republic of Congo",
                           "Lao People's Democratic Republic*" = "Laos",
                           "Philippines*" = "Philippines",
                           "Sri Lanka*" = "Sri Lanka",
                           "Malaysia*" = "Malaysia",
                           "Myanmar*" = "Myanmar",
                           "South Africa*" = "South Africa",
                           "China*"    = "China",                       
                           "Nigeria*"  =   "Nigeria",                    
                           "Bosnia and Herzegovina*" = "Bosnia and Herzegovina",          
                           "Serbia*"  =  "Serbia",                      
                           "Palestine, State of"      = "Palestine",        
                           "Montenegro*"   =   "Montenegro",                 
                           "Bahrain*"   = "Bahrain",                      
                           "Iraq*"  = "Iraq",                          
                           "Türkiye*"   = "Turkey",                      
                           "The Gambia" = "Gambia",                      
                           "Burkina Faso*"  = "Burkina Faso",                  
                           "Pakistan*"   = "Pakistan",                     
                           "Zambia*"  = "Zambia" ,                       
                           "Congo, Democratic Republic of"  = "Republic of Congo"))

## merge data
happines$region <- happines$Country2
full <- full_join(happines, world_coordinates,
                  
                  by="region")






p1 <- ggplot(full, aes(x = long,
                       y = lat,
                       group=group,
                       fill = `Happiness gap`)) +
  geom_polygon(color = "black") +
  labs(x = "Longitude",
       y = "Latitude") +
  theme(legend.position = "bottom",
  )  + 
  scale_fill_continuous(trans = 'reverse') +
labs(title = "A bad map", 
     subtitle='Size of the happiness gap between the top and bottom halves of each country population.\n(A higher gap means a higher happiness inequality.)', 
     caption="Day 4: #30DayMapChallenge\nThiyanga S.Talagala") + theme_minimal()
p1 
