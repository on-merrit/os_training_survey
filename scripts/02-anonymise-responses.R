library(tidyverse)

read_csv("data/results-survey731951.csv") %>% 
  select(-refurl, -c(groupTime15:E8Time), -E8) %>% 
  write_csv("data/processed/survey_anonymised.csv")


read_csv("data/label_base.csv") %>%
  slice(0) %>% 
  write_csv("data/label_base.csv")
