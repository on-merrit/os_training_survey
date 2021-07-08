consent <- select(df, id, starts_with("D1["))

consent_rec <- consent %>% 
  mutate(across(starts_with("D1["), .fns = dplyr::recode, Yes = TRUE, 
                No = FALSE),
         consented = (`D1[SQ001]` + `D1[SQ002]` + `D1[SQ003]` + `D1[SQ004]`) == 4)

df <- consent_rec %>% 
  filter(consented) %>% 
  select(id) %>% 
  left_join(df)


library(tidyverse)

df <- read_csv("data/processed/survey_anonymised.csv")

countries <- df %>% 
  select(E1) %>% 
  mutate(E1_rec = case_when(str_to_lower(E1) == "uk" ~ "United Kingdom",
                            E1 == "United Kingdom" ~ E1,
                            str_to_lower(E1) == "italy" ~ "Italy",
                            str_to_lower(E1) == "spain" ~ "Spain",
                            str_to_lower(E1) == "portugal" ~ "Portugal",
                            str_to_lower(E1) == "switzerland" ~ "Switzerland",
                            str_to_lower(E1) == "austria" ~ "Austria",
                            str_to_lower(E1) == "norway" ~ "Norway",
                            str_to_lower(E1) == "denmark" ~ "Denmark",
                            str_to_lower(E1) == "united states" ~ "United States",
                            str_to_lower(E1) == "germany" ~ "Germany",
                            TRUE ~ ""))

countries %>% 
  write_csv("data/processed/countries_to_merge.csv")



df <- countries %>%
  select(E1_rec) %>%
  left_join(df)


df <- left_join(df, countries)
