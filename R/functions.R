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


plot_bar <- function(df, var, title = NULL, reorder = TRUE, nudge_y = .04,
                     y_lab = NULL) {
  if (reorder) {
    plot_data <- df %>%
      count({{var}}) %>%
      mutate(prop = n/sum(n),
             label = glue::glue("{n} ({scales::percent(prop, accuarcy = .1)})"),
             xvar = fct_reorder({{var}}, n, .fun = "max"))
  } else {
    plot_data <- df %>%
      count({{var}}) %>%
      mutate(prop = n/sum(n),
             label = glue::glue("{n} ({scales::percent(prop, accuarcy = .1)})"),
             xvar = {{var}})
  }
  
  
  plot_data %>%
    ggplot(aes(xvar, prop)) +
    geom_lollipop() +
    coord_flip(clip = "off") +
    geom_text(aes(label = label), nudge_y = nudge_y) +
    scale_y_continuous(labels = function(x) scales::percent(x, accurarcy = 1)) + 
    labs(x = NULL, y = y_lab) +
    hrbrthemes::theme_ipsum(base_family = "Hind", grid = "")
}

