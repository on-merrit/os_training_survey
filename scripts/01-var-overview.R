library(tidyverse)

label_base <- read_csv("data/label_base.csv")


var_labels <- tibble(var_names = names(label_base))

var_labels %>% 
  separate(var_names, into = c("short_code", "question_text"),
           sep = "\\.\\s", extra = "merge") %>% 
  mutate(question_specification = str_extract(question_text, 
                                              "(?<=\\[).*?(?=\\])")) %>% 
  write_csv("data/processed/question_codes.csv")
