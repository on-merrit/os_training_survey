plot_likert <- function(df, center_for_likert = NULL, legend_rows = 2, 
                        centered = TRUE) {
  
  # remove don't know and irrelevant research
  old_levels <- levels(df[[1, 1]])
  new_levels <- old_levels[!(old_levels %in%
                               c("This topic is not relevant to my research",
                                 "This topic is not relevant for my research",
                                 "Don’t know/ Don’t have enough information"))]
  
  df <- mutate(df, across(.fns = factor, levels = new_levels))
  
  # prepare for likert
  df <- df %>% 
    set_names_for_likert() %>% 
    as.data.frame()
  
  # remove other levels
  df <- df %>% 
    select(-any_of("Other"))
  
  labels_df <- df %>% 
    summarise(across(.fns = ~sum(!is.na(.x)))) %>% 
    pivot_longer(everything()) %>% 
    mutate(label = glue::glue("n = {value}"))
  
  p2 <- labels_df %>% 
    ggplot(aes(x = 1, y = name, label = label)) +
    geom_text(size = 3.15) +
    theme_void() 
  
  plot_it <- if (!is.null(center_for_likert)) {
    function(x, center, ...) plot(x, center = center_for_likert, ...)
  } else {
    function(x, ...) plot(x, ...)
  }
  
  # plot it
  p1 <- df %>% 
    likert::likert() %>% 
    plot_it(centered = centered) +
    guides(fill = guide_legend(title = NULL, nrow = legend_rows))
  
  p1 + p2 +
    plot_layout(widths = c(6, 1))
}

set_names_for_likert <- function(df) {
  old_names <- names(df)
  
  new_names <- tar_read(var_overview) %>% 
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
    ggalt::geom_lollipop() +
    coord_flip(clip = "off") +
    geom_text(aes(label = label), nudge_y = nudge_y) +
    scale_y_continuous(labels = function(x) scales::percent(x, accurarcy = 1)) + 
    labs(x = NULL, y = y_lab) +
    hrbrthemes::theme_ipsum(base_family = "Hind", grid = "")
}