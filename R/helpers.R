plot_likert <- function(df, question_codes, title = NULL) {
  pdata <- df %>% 
    pivot_longer(everything(), names_to = "var") %>% 
    filter(!is.na(value), 
           !(value %in% c("This topic is not relevant to my research", 
                          "Don’t know/ Don’t have enough information"))) %>% 
    left_join(question_codes, by = c("var" = "short_code")) %>% 
    count(question_specification, value) %>% 
    group_by(question_specification) %>% 
    mutate(prop = n/sum(n)) 
  
  
  pdata %>% 
    ggplot(aes(stringr::str_wrap(question_specification, 40), prop, 
               fill = fct_rev(value))) +
    geom_col(width = .7) +
    coord_flip() +
    scale_y_continuous(labels = scales::percent) +
    labs(x = NULL, y = NULL, fill = NULL,
         title = title) +
    theme(legend.position = "top") +
    guides(fill = guide_legend(reverse = TRUE))
}


recode_successful <- function(df1, df2) {
  all.equal(
    df1 %>% 
      summarise(across(.fns = ~sum(is.na(.x)))),
    df2 %>% 
      summarise(across(.fns = ~sum(is.na(.x))))
  )
}
