library(dplyr)
library(tidyr)
library(here)

birds <- readr::read_csv("https://www.birds.cornell.edu/clementschecklist/wp-content/uploads/2021/08/eBird_Taxonomy_v2021.csv")

names(birds) <- tolower(names(birds))
birds <- birds %>%
  select(category, primary_com_name, species_group) %>%
  filter(category == "species") %>%
  select(-category) %>%
  fill(species_group, .direction = "down")

write.csv(birds, here("data", "birds.csv"))