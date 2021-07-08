remove_non_consenters <- function(df) {
  consent <- select(df, id, starts_with("D1["))
  
  consent_rec <- consent %>% 
    mutate(across(starts_with("D1["), .fns = dplyr::recode, Yes = TRUE, 
                  No = FALSE),
           consented = (`D1[SQ001]` + `D1[SQ002]` + `D1[SQ003]` + `D1[SQ004]`) == 4)
  
  df <- consent_rec %>% 
    filter(consented) %>% 
    select(id) %>% 
    left_join(df)
  
  df
}


countries <- read_csv("data/processed/countries_merged.csv")
countries_distinct <- distinct(countries)

df_small <- df %>% 
  select(id, E1)


df_small

df_small %>% 
  left_join(countries_distinct) 

add_country <- function(raw_data, merged_countries) {
  
}
