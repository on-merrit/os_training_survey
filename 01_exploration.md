---
title: "Survey Results Task 3.3 731951"
author: "Anja Rainer"
date: "02 Juli, 2021"
output: 
  html_document:
    keep_md: true
---




```r
answer_levels <- c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                   "Agree", "Strongly agree", 
                   "This topic is not relevant to my research", 
                   "Don’t know/ Don’t have enough information")


a1_df <- df %>% 
  select(starts_with("A1[")) 

a1_df_rec <- a1_df %>% 
  mutate(across(.fns = factor, levels = answer_levels))


a1_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A1[SQ001]` `A1[SQ002]` `A1[SQ003]` `A1[SQ004]` `A1[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1           8           8           9          13           9
```



```r
a1_df_rec %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A1[SQ001]` `A1[SQ002]` `A1[SQ003]` `A1[SQ004]` `A1[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1           8           8           9          13           9
```

