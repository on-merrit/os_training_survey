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


plot_bar <- function(df,  var, title = NULL, reorder = TRUE) {
  if (reorder) {
    plot_data <- df %>%
      count({{var}}) %>%
      mutate(prop = n/sum(n),
             xvar = fct_reorder({{var}}, n, .fun = "max"))
  } else {
    plot_data <- df %>%
      count({{var}}) %>%
      mutate(prop = n/sum(n),
             xvar = {{var}})
  }
  
  
  plot_data %>%
    ggplot(aes(xvar, prop)) +
    geom_col(width = .7) +
    scale_y_continuous(labels = scales::percent) + 
    coord_flip() +
    labs(x = NULL, title = title)
}

