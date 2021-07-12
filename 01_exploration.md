---
title: "Survey Results Task 3.3 731951"
author: "Anja Rainer"
date: "12 Juli, 2021"
output: 
  html_document:
    keep_md: true
---






```r
# number of cases:
nrow(df)
```

```
## [1] 167
```
Our sample is based on 167 cases.

# Missing data


```r
vis_dat(df)
```

![](01_exploration_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```r
visdat::vis_miss(df)
```

![](01_exploration_files/figure-html/unnamed-chunk-1-2.png)<!-- -->


```r
df %>% 
  select_if(function(x) (sum(is.na(x)))/length(x) > .1) %>% 
  vis_miss()
```

![](01_exploration_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

# Demographics

# Age cohorts


```r
answer_levels_e3 <- c("<20", "20-29", "30-39", "40-49", "50-59", "60-69", "70+")

e3_df <- df %>% 
  select("E3")

e3_df_rec <- e3_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_e3))


e3_df_rec %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 1
##      E3
##   <int>
## 1     0
```

```r
e3_df_rec %>%
  mutate(across(.fns = as.numeric)) %>% 
  summarise(across(everything(), ~mean(.x, na.rm = TRUE)))
```

```
## # A tibble: 1 x 1
##      E3
##   <dbl>
## 1  4.49
```

```r
e3_df_rec %>%
  ggplot(aes(E3)) +
  geom_bar(width = .7) +
  coord_flip() +
  labs(x = NULL, title = "Age cohorts")
```

![](01_exploration_files/figure-html/unnamed-chunk-3-1.png)<!-- -->


# Gender


```r
answer_levels_e2 <- c("Man", "Woman", "Prefer not to say", "Other")

e2_df <- df %>% 
  select("E2")

e2_df_rec <- e2_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_e2))


e2_df_rec %>% 
  count(E2) %>% 
  ggplot(aes(fct_reorder(E2, n, .fun = "max"), n)) +
  geom_col(width = .7) +
  coord_flip() +
  labs(x = NULL, title = "Gender")
```

![](01_exploration_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

# Publish first academic publication


```r
e3b_df <- df %>% 
  select("E3b") %>% 
  filter(E3b > 1960)

e3b_df %>% 
  ggplot(aes(E3b)) +
  geom_histogram() +
  labs(x = NULL, title = "Publish first academic publication")
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](01_exploration_files/figure-html/unnamed-chunk-5-1.png)<!-- -->


# Highest education


```r
answer_levels_e4 <- c("Post-secondary non-tertiary education (e.g. VET Schools, schools of healthcare and nursing)", "Short-cycle tertiary education (e.g. master schools, colleges, vocational training schools)", "Bachelor or equivalent", "Master or equivalent", "Doctorate or equivalent", "Other")

answer_labels_e4 <- str_wrap(answer_levels_e4, 30)

e4_df <- df %>% 
  select("E4")

e4_df_rec <- e4_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_e4, 
                labels = answer_labels_e4))

e4_df_rec %>%
  # rename(Post-secondary non-tertiary education = Post-secondary non-tertiary education (e.g. VET Schools, schools of healthcare and nursing) %>%
  count(E4) %>%
  ggplot(aes(fct_reorder(E4, n, .fun = "max"), n)) +
  geom_col(width = .7) +
  coord_flip() +
  labs(x = NULL, title = "Highest education")
```

![](01_exploration_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

# Types of institution


```r
answer_levels_e5 <- c("University", "Public research institute", "Private research institute", "Company", "Nonprofit", "Other")

e5_df <- df %>% 
  select("E5")

e5_df_rec <- e5_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_e5))

e5_df_rec %>% 
  count(E5) %>% 
  ggplot(aes(fct_reorder(E5, n, .fun = "max"), n)) +
  geom_col(width = .7) +
  coord_flip() +
  labs(x = NULL, title = "In what type of institution do you work?")
```

![](01_exploration_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

# Position


```r
answer_levels_e6 <- c("Junior Researcher", "Senior Researcher", "Ph.D. student", "Postdoctoral fellow/ researcher", "Assistant professor", 
                      "Associate professor", "Full professor", "Associate research scientist", "Instructor", "Lecturer", "Adjunct professor", 
                      "Technician or lab manager", "Core facility manager", "Other")

e6_df <- df %>% 
  select("E6")

e6_df_rec <- e6_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_e6))

e6_df_rec %>% 
  count(E6) %>% 
  ggplot(aes(fct_reorder(E6, n, .fun = "max"), n)) +
  geom_col(width = .7) +
  coord_flip() +
  labs(x = NULL, title = "Position")
```

![](01_exploration_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

# Respondents by disciplines


```r
answer_levels_e7 <- c("Natural Sciences", "Engineering and technology", "Medical and health sciences", "Agricultural and Veterinary sciences", 
                      "Social Sciences", "Humanities and the Arts")

e7_df <- df %>% 
  select("E7")

e7_df_rec <- e7_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_e7))

e7_df_rec %>% 
  count(E7) %>% 
  ggplot(aes(fct_reorder(E7, n, .fun = "max"), n)) +
  geom_col(width = .7) +
  coord_flip() +
  labs(x = NULL, title = "Respondents by discipline")
```

![](01_exploration_files/figure-html/unnamed-chunk-9-1.png)<!-- -->


# A1 Practices in OS


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
## 1           3           3           4           8           4
```



```r
a1_df_rec %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A1[SQ001]` `A1[SQ002]` `A1[SQ003]` `A1[SQ004]` `A1[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1           3           3           4           8           4
```



```r
visdat::vis_miss(a1_df_rec)
```

![](01_exploration_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

```r
a1_df_rec %>% 
  plot_likert(question_codes, "Practices regarding OS")
```

![](01_exploration_files/figure-html/unnamed-chunk-12-2.png)<!-- -->


# A2 Own pratices regarding Open Access publishing


```r
answer_levels_2 <- c("Never", "Rarely", "Sometimes",
                   "Often", "Always", "This topic is not relevant to my research", 
                   "Don’t know/ Don’t have enough information")


a2_df <- df %>% 
  select(starts_with("A2[")) 

a2_df_rec <- a2_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_2))


a2_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A2[SQ001]` `A2[SQ002]` `A2[SQ003]` `A2[SQ004]` `A2[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1           3           2           5           7           7
```

```r
a2_df_rec %>% 
  plot_likert(question_codes, "Own pratices regarding Open Access publishing")
```

![](01_exploration_files/figure-html/unnamed-chunk-13-1.png)<!-- -->


# A3 Own practices regarding Research Data Management


```r
a3_df <- df %>% 
  select(starts_with("A3[")) 

a3_df_rec <- a3_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_2))


a3_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A3[SQ005]` `A3[SQ001]` `A3[SQ002]` `A3[SQ003]` `A3[SQ004]`
##         <int>       <int>       <int>       <int>       <int>
## 1           4           5           7           7           8
```

```r
a3_df_rec %>% 
  plot_likert(question_codes, "Own practices regarding Research Data Management")
```

![](01_exploration_files/figure-html/unnamed-chunk-14-1.png)<!-- -->


# A4 Practices regarding Reproducible Research Scale


```r
a4_df <- df %>% 
  select(starts_with("A4[")) 

a4_df_rec <- a4_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_2))


a4_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A4[SQ001]` `A4[SQ002]` `A4[SQ003]` `A4[SQ004]` `A4[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1           5           5           6          12           7
```

```r
a4_df_rec %>% 
  plot_likert(question_codes, "Practices regarding Reproducible Research Scale")
```

![](01_exploration_files/figure-html/unnamed-chunk-15-1.png)<!-- -->


# A5 Pratices regarding Open Peer Review Scale


```r
answer_levels <- c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                   "Agree", "Strongly agree", 
                   "This topic is not relevant to my research", 
                   "Don’t know/ Don’t have enough information")


a5_df <- df %>% 
  select(starts_with("A5[")) 

a5_df_rec <- a5_df %>% 
  mutate(across(.fns = factor, levels = answer_levels))


a5_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A5[SQ001]` `A5[SQ002]` `A5[SQ003]` `A5[SQ004]` `A5[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1           6          10          10          10          12
```

```r
a5_df_rec %>% 
  plot_likert(question_codes, "Pratices regarding Open Peer Review Scale")
```

![](01_exploration_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


# A6 Practices regarding Open Source Software Scale


```r
a6_df <- df %>% 
  select(starts_with("A6[")) 

a6_df_rec <- a6_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_2))


a6_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A6[SQ001]` `A6[SQ002]` `A6[SQ003]` `A6[SQ004]` `A6[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1           9           8           9           9           9
```

```r
a6_df_rec %>% 
  plot_likert(question_codes, "Practices regarding Open Source Software Scale")
```

![](01_exploration_files/figure-html/unnamed-chunk-17-1.png)<!-- -->


# A7 Practices regarding Licensing Scale


```r
a7_df <- df %>% 
  select(starts_with("A7[")) 

a7_df_rec <- a7_df %>% 
  mutate(across(.fns = factor, levels = answer_levels))


a7_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A7[SQ001]` `A7[SQ002]` `A7[SQ003]` `A7[SQ004]` `A7[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1          11          13          14          11           9
```

```r
a7_df_rec %>% 
  plot_likert(question_codes, "Practices regarding Licensing Scale")
```

![](01_exploration_files/figure-html/unnamed-chunk-18-1.png)<!-- -->


# A8 Practices regarding Research Integrity Scale


```r
a8_df <- df %>% 
  select(starts_with("A8[")) 

a8_df_rec <- a8_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_2))


a8_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A8[SQ001]` `A8[SQ002]` `A8[SQ003]` `A8[SQ004]` `A8[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1           5           5           5           5           7
```

```r
a8_df_rec %>% 
  plot_likert(question_codes, "Practices regarding Research Integrity Scale")
```

![](01_exploration_files/figure-html/unnamed-chunk-19-1.png)<!-- -->


# A9 Practices regarding Citizen Science (information, consultation, public participation )


```r
a9_df <- df %>% 
  select(starts_with("A9[")) 

a9_df_rec <- a9_df %>% 
  mutate(across(.fns = factor, levels = answer_levels))


a9_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A9[SQ001]` `A9[SQ002]` `A9[SQ003]` `A9[SQ004]` `A9[SQ005]`
##         <int>       <int>       <int>       <int>       <int>
## 1           5           5           4           5           6
```

```r
a9_df_rec %>% 
  plot_likert(question_codes, "Practices regarding Citizen Science")
```

![](01_exploration_files/figure-html/unnamed-chunk-20-1.png)<!-- -->


# A10 Practices regarding Gender Issues Scale


```r
a10_df <- df %>% 
  select(starts_with("A10[")) 

a10_df_rec <- a10_df %>% 
  mutate(across(.fns = factor, levels = answer_levels))


a10_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 5
##   `A10[SQ001]` `A10[SQ002]` `A10[SQ003]` `A10[SQ004]` `A10[SQ005]`
##          <int>        <int>        <int>        <int>        <int>
## 1            4            4            5            6            7
```

```r
a10_df_rec %>% 
  plot_likert(question_codes, "Practices regarding Gender Issues Scale")
```

![](01_exploration_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

# Part B Training on OS topics

# B1 Attended Training Events


```r
answer_levels_b1 <- c("None", "1", "2", "3-5", "more than 5")


b1_df <- df %>% 
  select(starts_with("B1[")) 

b1_df_rec <- b1_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_b1))


b1_df %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 11
##   `B1[SQ001]` `B1[SQ002]` `B1[SQ003]` `B1[SQ004]` `B1[SQ005]` `B1[SQ006]`
##         <int>       <int>       <int>       <int>       <int>       <int>
## 1           0           0           0           0           0           0
## # ... with 5 more variables: B1[SQ007] <int>, B1[SQ008] <int>, B1[SQ009] <int>,
## #   B1[SQ010] <int>, B1[SQ013] <int>
```

```r
b1_df_rec %>% 
  plot_likert(question_codes, "Attended Training Events")
```

![](01_exploration_files/figure-html/unnamed-chunk-22-1.png)<!-- -->


# B3 Attended Different Types of Training Sessions


```r
answer_levels_b3 <- c("Never", "Once", "More than once")


b3_df <- df %>% 
  select(starts_with("B3[")) 

b3_df_rec <- b3_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_b3))


b3_df_rec %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 10
##   `B3[SQ001]` `B3[SQ002]` `B3[SQ003]` `B3[SQ004]` `B3[SQ005]` `B3[SQ006]`
##         <int>       <int>       <int>       <int>       <int>       <int>
## 1           0           0           0           0           0           0
## # ... with 4 more variables: B3[SQ007] <int>, B3[SQ008] <int>, B3[SQ009] <int>,
## #   B3[SQ013] <int>
```

```r
b3_df_rec %>% 
  plot_likert(question_codes, "Attended Different Types of Training Sessions")
```

![](01_exploration_files/figure-html/unnamed-chunk-23-1.png)<!-- -->


# B5 Hours of training


```r
answer_levels_b5 <- c("None", "1", "2", "3-5", "More than 5", "Other")

b5_df <- df %>% 
  select("B5")

b5_df_rec <- b5_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_b5))

recode_successful(b5_df, b5_df_rec)
```

```
## [1] TRUE
```

```r
b5_df_rec %>% 
  count(B5) %>% 
  ggplot(aes(fct_reorder(B5, n, .fun = "max"), n)) +
  geom_col(width = .7) +
  coord_flip() +
  labs(x = NULL, title = "Hours of training")
```

![](01_exploration_files/figure-html/unnamed-chunk-24-1.png)<!-- -->


# B6 Attended Different Types of Training Sessions


```r
answer_levels_b6 <- c("I didn’t receive training", "I need more training", 
                        "I received adequate training", "This topic is not relevant for my research")


b6_df <- df %>% 
  select(starts_with("B6[")) 

b6_df_rec <- b6_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_b6))


b6_df_rec %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 11
##   `B6[SQ001]` `B6[SQ002]` `B6[SQ003]` `B6[SQ004]` `B6[SQ005]` `B6[SQ006]`
##         <int>       <int>       <int>       <int>       <int>       <int>
## 1           0           0           0           0           0           0
## # ... with 5 more variables: B6[SQ007] <int>, B6[SQ008] <int>, B6[SQ009] <int>,
## #   B6[SQ010] <int>, B6[SQ013] <int>
```

```r
b6_df_rec %>% 
  plot_likert(question_codes, "Attended Different Types of Training Sessions")
```

![](01_exploration_files/figure-html/unnamed-chunk-25-1.png)<!-- -->


# B8 Attendance of first formal training in any Open Science topic


```r
answer_levels_b8 <- c("During doctoral studies", "As a researcher", "During a conference", "Other")

b8_df <- df %>% 
  select("B8")

b8_df_rec <- b8_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_b8))


b8_df_rec %>% 
  count(B8) %>% 
  ggplot(aes(fct_reorder(B8, n, .fun = "max"), n)) +
  geom_col(width = .7) +
  coord_flip() +
  labs(x = NULL, title = "Attendance of first formal training in any Open Science topic")
```

![](01_exploration_files/figure-html/unnamed-chunk-26-1.png)<!-- -->


Most responses from the "Other" category mention that they never received any
training.

# B9 Who provided the training sessions you attended?


```r
answer_levels_3 <- c("Yes", "No")

b9_df <- df %>% 
  select(starts_with("B9[")) 

b9_df_rec <- b9_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_3))


b9_df_rec %>% 
  plot_likert(question_codes, "Who provided the training sessions you attended?")
```

![](01_exploration_files/figure-html/unnamed-chunk-27-1.png)<!-- -->


# B10 Preferred way to learn OS topics


```r
b10_df <- df %>% 
  select(starts_with("B10["))

b10_df_rec <- b10_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_3))


b10_df_rec %>% 
  plot_likert(question_codes, "Preferred way to learn OS topics")
```

![](01_exploration_files/figure-html/unnamed-chunk-28-1.png)<!-- -->


# B11 Has your awareness of open science practices increased after the training you attended?


```r
answer_levels_4 <- c("Don’t know", "Highly disagree", "Disagree",
                     "Neither agree nor disagree",
                     "Agree", "Highly agree")


b11_df <- df %>% 
  select(starts_with("B11[")) 

b11_df_rec <- b11_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_4))

recode_successful(b11_df, b11_df_rec)
```

```
## [1] TRUE
```

```r
b11_df_rec %>% 
  plot_likert(question_codes, "Has your awareness of open science practices\nincreased after the training you attended?")
```

![](01_exploration_files/figure-html/unnamed-chunk-29-1.png)<!-- -->


# B11 Would you share your experience with open science practices and tools with colleagues?


```r
b12_df <- df %>% 
  select(starts_with("B12[")) 

b12_df_rec <- b12_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_4))


b12_df_rec %>% 
  summarise(across(.fns = ~sum(is.na(.x))))
```

```
## # A tibble: 1 x 4
##   `B12[SQ001]` `B12[SQ002]` `B12[SQ003]` `B12[SQ004]`
##          <int>        <int>        <int>        <int>
## 1            0            0            0            0
```

```r
b12_df_rec %>% 
  plot_likert(question_codes, "Would you share your experience with open science practices\nand tools with colleagues?")
```

![](01_exploration_files/figure-html/unnamed-chunk-30-1.png)<!-- -->



# Further todos

- check out cases with weird first year of publication `df %>% filter(id %in% c(356, 420, 129))` 



