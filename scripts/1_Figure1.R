# Map of countries present in the dataset

# Author: Chris LeBoa
# Version: 2021-11-13

# Libraries
library(tidyverse)
library(sf)
library(lwgeom)


#[Natural Earth](http://www.naturalearthdata.com) provides free vector and raster map data in a range of scales.
#For this exercise, we will use cultural vector data at the 1:110m scale found on [this page](http://www.naturalearthdata.com/downloads/110m-cultural-vectors/).

#In particular, download the first file in the section _Admin 0 - Countries_ and save in a place other than a GitHub repo.


# Parameters

countries <-
  read_sf("/Users/ChrisLeBoa/Documents/Work/Class Files /Stanford/Coterm Year/Winter Quarter/DCL/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp")

data_world <-
  data_all %>%
  separate_rows(Location, sep=",") %>%
  group_by(Location) %>%
  count(n = n()) %>%
  mutate(Location = str_trim(Location, "both")) %>%
  arrange(desc(nn)) %>%
  left_join(countries, by = c("Location" = "ADMIN")) %>%
  mutate(study_count = nn)

ggplot() +
  geom_sf(data = countries, aes( geometry = geometry)) +
  geom_sf(data = data_world, aes( fill = study_count, geometry = geometry)) +
  theme_minimal() +
  scale_fill_viridis_c() +
  theme(legend.position = "bottom") +
  labs(
    title = "Geographic distribution of study population by country",
    fill = "Number of Studies"
  )




#===============================================================================

Code
