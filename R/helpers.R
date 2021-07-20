plot_likert <- function(df, question_codes, title = NULL) {
  
  # remove don't know and irrelevant research
  old_levels <- levels(df[[1, 1]])
  new_levels <- old_levels[!(old_levels %in%
                               c("This topic is not relevant to my research",
                                 "Don’t know/ Don’t have enough information"))]
  
  df <- mutate(df, across(.fns = factor, levels = new_levels))
  
  # plot it
  df %>% 
    set_names_for_likert() %>% 
    as.data.frame() %>% 
    likert::likert() %>% 
    plot() +
    guides(fill = guide_legend(title = NULL, nrow = 2)) +
    labs()
}

set_names_for_likert <- function(df, var_overview = question_codes) {
  old_names <- names(df)
  
  new_names <- var_overview %>% 
    filter(short_code %in% old_names) %>% 
    pull(question_specification)
  
  df_new <- set_names(df, new_names)
  df_new
}


recode_successful <- function(df1, df2) {
  all.equal(
    df1 %>% 
      summarise(across(.fns = ~sum(is.na(.x)))),
    df2 %>% 
      summarise(across(.fns = ~sum(is.na(.x))))
  )
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
    filter(!is.na({{var}})) %>%
    ggplot(aes(xvar, prop)) +
    geom_lollipop() +
    coord_flip(clip = "off") +
    geom_text(aes(label = label), nudge_y = nudge_y) +
    scale_y_continuous(labels = function(x) scales::percent(x, accurarcy = 1)) + 
    labs(x = NULL, y = y_lab) +
    hrbrthemes::theme_ipsum(base_family = "Hind", grid = "")
}