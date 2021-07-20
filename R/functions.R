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



add_country <- function(raw_data, merged_countries) {
  
  countries_distinct <- distinct(merged_countries)
  
  raw_data %>% 
    left_join(countries_distinct, by = "E1") 
}

create_var_overview <- function(label_base) {
  label_base <- read_csv(label_base, col_types = cols(
    .default = col_character()
  ))
  
  
  var_labels <- tibble(var_names = names(label_base))
  
  out <- var_labels %>% 
    separate(var_names, into = c("short_code", "question_text"),
             sep = "\\.\\s", extra = "merge") %>% 
    mutate(question_specification = str_extract(question_text, 
                                                "(?<=\\[).*?(?=\\])"))
  write_csv(out, "data/processed/question_codes.csv")
  
  out
}





