---
title: "Survey Results Task 3.3 Part C and D"
author: "Anja Rainer"
date: "25 Oktober, 2021"
output: 
  html_document:
    keep_md: true
editor_options: 
  chunk_output_type: inline
---



# C1 Institution: OA policy

Does your institution have an open access policy? (Y/N/ I don’t know)


```r
answer_levels_5 <- c("I don't know", "No", "Yes")

c1_df <- df %>% 
  select("C1")

c1_df_rec <- c1_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_5))


c1_df_rec %>% 
  plot_bar(C1, title = "Institution: OA policy", reorder = TRUE, nudge_y = .08)
```

![](02_descriptives_parts_c_d_files/figure-html/c1-1.png)<!-- -->

# C3 Institution: OS/OA practices recommandation

Does your institution recommend open science/ open access practices? (Y/N)


```r
answer_levels_6 <- c("No", "Yes")

c3_df <- df %>% 
  select("C3")

c3_df_rec <- c3_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_6))


c3_df_rec %>% 
  plot_bar(C3, title = "Institution: OS/OA practices recommandation", reorder = TRUE, nudge_y = .08)
```

![](02_descriptives_parts_c_d_files/figure-html/c3-1.png)<!-- -->

# c5 Helpdesk/group to support any issues

Is there a dedicated helpdesk/ group to support any issues related to the open science / open access policy? (Y/N/ I don’t know)


```r
c5_df <- df %>% 
  select("C5")

c5_df_rec <- c5_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_5))


c5_df_rec %>% 
  plot_bar(C5, title = "Helpdesk/group to support any issues", reorder = FALSE, nudge_y = .06)
```

![](02_descriptives_parts_c_d_files/figure-html/c5-1.png)<!-- -->


# C6 Guidance on how to comply with the policies by the financing entities that require OA to publications

Do you receive any guidance on how to comply with the policies issued by the financing entities that require open access to publications, such as the European Commission or the European Research Council? (Y/N/ I don’t know)


```r
c6_df <- df %>% 
  select("C6")

c6_df_rec <- c6_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_5))

c6_df_rec %>% 
  plot_bar(C6, title = "Guidance on how to comply with the policies by the financing entities that require OA to publications", reorder = FALSE, nudge_y = .06)
```

![](02_descriptives_parts_c_d_files/figure-html/c6-1.png)<!-- -->

# C7 Financial support in paying article processing charges (APCs)

Does your institution support you financially in paying article processing charges (APCs)? (Y/N/ I don’t know))


```r
c7_df <- df %>% 
  select("C7")

c7_df_rec <- c7_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_5))

c7_df_rec %>% 
  plot_bar(C7, title = "Financial support in paying article processing charges (APCs)", reorder = FALSE, nudge_y = .07)
```

![](02_descriptives_parts_c_d_files/figure-html/c7-1.png)<!-- -->


# C8 Degree of support in practicing OS at institution

To what degree are you supported in practicing Open Science at your institution?


```r
answer_levels_7 <- c("Don’t know/ Don’t have enough information", "I do not receive any support or incentives", "I do not receive any support or incentives but would like to", "I receive some support or incentives", 
"I receive sufficient support or incentives")

c8_df <- df %>% 
  select(starts_with("C8[")) 

c8_df_rec <- c8_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_7))

c8_df_rec %>% 
  plot_likert()
```



|Variable                                                                                                      |I do not receive any support or incentives |I do not receive any support or incentives but would like to |I receive some support or incentives |I receive sufficient support or incentives |
|:-------------------------------------------------------------------------------------------------------------|:------------------------------------------|:------------------------------------------------------------|:------------------------------------|:------------------------------------------|
|Access to technical infrastructure (software, storage, databases, publication and/or data repositories, etc.) |33 (23.2%)                                 |18 (12.7%)                                                   |47 (33.1%)                           |44 (31.0%)                                 |
|Career perspectives and recognition                                                                           |61 (44.5%)                                 |32 (23.4%)                                                   |31 (22.6%)                           |13 (9.5%)                                  |
|Financial support and rewards                                                                                 |54 (39.4%)                                 |24 (17.5%)                                                   |45 (32.8%)                           |14 (10.2%)                                 |
|Information on funders’ policies and recommendations regarding Open Science                                   |40 (28.0%)                                 |27 (18.9%)                                                   |48 (33.6%)                           |28 (19.6%)                                 |
|Legal support for licensing research outputs and on IPR or GDPR issues                                        |34 (27.9%)                                 |22 (18.0%)                                                   |42 (34.4%)                           |24 (19.7%)                                 |
|Support by an Ethics committee                                                                                |33 (24.3%)                                 |16 (11.8%)                                                   |41 (30.1%)                           |46 (33.8%)                                 |
|Training on different aspects of Open Science                                                                 |43 (31.9%)                                 |27 (20.0%)                                                   |47 (34.8%)                           |18 (13.3%)                                 |


![](02_descriptives_parts_c_d_files/figure-html/c8-1.png)<!-- -->


# C10: Other initiatives incentivising Open Science practices at institution

Are there other initiatives incentivising Open Science practices at your institution (eg. Open Science cafes, Data champions)? (Y/N)


```r
c10_df <- df %>% 
  select("C10")

c10_df_rec <- c10_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_6))

c10_df_rec %>% 
  plot_bar(C10, title = "Other initiatives incentivising Open Science practices at institution", reorder = FALSE, nudge_y = .1)
```

![](02_descriptives_parts_c_d_files/figure-html/c10-1.png)<!-- -->

# Part D: Drivers and barriers to practicing Open Science

# D2 Summarised views: What would you say OS is?

Overall, if you had to summarise your views, what would you say Open Science is?


```r
d2_df <- df %>% 
  select("D2[SQ001]", "D2[SQ002]", "D2[SQ003]", "D2[SQ004]", "D2[SQ005]", "D2[SQ006]", "D2[SQ007]")

d2_df_rec <- d2_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_6))

d2_df_rec %>% 
  plot_likert(legend_rows = 1)
```



|Variable                                                      |No          |Yes        |
|:-------------------------------------------------------------|:-----------|:----------|
|A real threat to my research                                  |158 (94.6%) |9 (5.4%)   |
|A worrying new perspective                                    |161 (96.4%) |6 (3.6%)   |
|An exciting opportunity, mostly with benefits                 |115 (68.9%) |52 (31.1%) |
|An opportunity, with the benefits outweighing the drawbacks   |121 (72.5%) |46 (27.5%) |
|An unimportant bureaucratic burden                            |159 (95.2%) |8 (4.8%)   |
|Mostly positive, it has benefits but also important drawbacks |106 (63.5%) |61 (36.5%) |
|Not relevant for my research                                  |152 (91.0%) |15 (9.0%)  |


![](02_descriptives_parts_c_d_files/figure-html/d2-1.png)<!-- -->

# D3  Most significant barriers facing while embracing an OS perspective

Which are the most significant barriers you will be facing while embracing an Open Science perspective?


```r
answer_levels_8 <- c("Don’t know/ Don’t have enough information", "No barrier", "Minor barrier",
                     "Significant barrier", "Very significant barrier")

d3_df <- df %>% 
  select("D3[SQ001]", "D3[SQ002]", "D3[SQ003]", "D3[SQ004]", "D3[SQ005]", "D3[SQ006]", "D3[SQ007]", "D3[SQ008]")

d3_df_rec <- d3_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_8))

d3_df_rec %>% 
  plot_likert(legend_rows = 1)
```



|Variable                                                         |No barrier |Minor barrier |Significant barrier |Very significant barrier |
|:----------------------------------------------------------------|:----------|:-------------|:-------------------|:------------------------|
|Extra effort                                                     |18 (12.2%) |50 (33.8%)    |47 (31.8%)          |33 (22.3%)               |
|Lack of clarity around where benefits arise                      |43 (29.3%) |49 (33.3%)    |42 (28.6%)          |13 (8.8%)                |
|Lack of clarity in which sources/platforms to trust              |21 (14.2%) |37 (25.0%)    |45 (30.4%)          |45 (30.4%)               |
|Lack of clarity where to find relevant information               |26 (17.6%) |46 (31.1%)    |59 (39.9%)          |17 (11.5%)               |
|Lack of clear steps to follow. How do I begin? How do I proceed? |24 (16.7%) |40 (27.8%)    |52 (36.1%)          |28 (19.4%)               |
|Lack of proper infrastructure                                    |29 (21.3%) |35 (25.7%)    |51 (37.5%)          |21 (15.4%)               |
|Time constraints                                                 |28 (19.0%) |40 (27.2%)    |56 (38.1%)          |23 (15.6%)               |


![](02_descriptives_parts_c_d_files/figure-html/d3-1.png)<!-- -->

# D5 Main drivers to participate OS

What could be the main drivers for you to practice open science?


```r
answer_levels_9 <- c("Don’t know/ Don’t have enough information", "No driver", "Minor driver",
                     "Significant driver", "Very significant driver")

d5_df <- df %>% 
  select(starts_with("D5[")) 

d5_df_rec <- d5_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_9))

d5_df_rec %>% 
  plot_likert(legend_rows = 1)
```



|Variable                                                                                           |No driver  |Minor driver |Significant driver |Very significant driver |
|:--------------------------------------------------------------------------------------------------|:----------|:------------|:------------------|:-----------------------|
|Career progression policies based on the adoption of open science practices                        |26 (17.1%) |37 (24.3%)   |55 (36.2%)         |34 (22.4%)              |
|Ethics principles                                                                                  |15 (9.9%)  |27 (17.9%)   |62 (41.1%)         |47 (31.1%)              |
|Funder policy mandating open access to the research outputs                                        |9 (5.7%)   |27 (17.1%)   |62 (39.2%)         |60 (38.0%)              |
|Institutional policy mandating open science practices                                              |7 (4.5%)   |30 (19.2%)   |75 (48.1%)         |44 (28.2%)              |
|Publisher policies and requirements (e.g. data availability statement)                             |12 (7.7%)  |34 (21.9%)   |71 (45.8%)         |38 (24.5%)              |
|Support and wide adoption of open science practices in my research community                       |13 (8.4%)  |32 (20.8%)   |70 (45.5%)         |39 (25.3%)              |
|The value of sharing my research outputs in relation to societal ideals (e.g. access to knowledge) |6 (3.9%)   |21 (13.6%)   |71 (46.1%)         |56 (36.4%)              |


![](02_descriptives_parts_c_d_files/figure-html/d5-1.png)<!-- -->

# D7 Drivers or barriers to practice Open Science

Would you say the following factors are drivers or barriers for you to practice Open Science?


```r
answer_levels_9 <- c("Don’t know/ Don’t have enough information", "Barrier", "Neither barrier nor driver",
                     "Driver")

d7_df <- df %>% 
  select(starts_with("D7[")) 

d7_df_rec <- d7_df %>% 
  mutate(across(.fns = factor, levels = answer_levels_9))

d7_df_rec %>% 
  plot_likert(legend_rows = 1)
```



|Variable                                                                         |Barrier     |Neither barrier nor driver |Driver      |
|:--------------------------------------------------------------------------------|:-----------|:--------------------------|:-----------|
|Article processing charges (APCs)                                                |130 (85.5%) |16 (10.5%)                 |6 (3.9%)    |
|Availability of high-quality open access publication choices in my research area |31 (20.1%)  |33 (21.4%)                 |90 (58.4%)  |
|Collaboration and communication among researchers                                |8 (5.4%)    |42 (28.2%)                 |99 (66.4%)  |
|Difficulties of applying licenses to publications/ data                          |70 (55.6%)  |51 (40.5%)                 |5 (4.0%)    |
|Plagiarism or theft of ideas                                                     |58 (41.7%)  |67 (48.2%)                 |14 (10.1%)  |
|Publisher’s policies on the sharing of publications/manuscripts                  |76 (51.0%)  |45 (30.2%)                 |28 (18.8%)  |
|Researcher evaluation based on citation metrics (e.g. impact factor, h-index)    |34 (23.4%)  |54 (37.2%)                 |57 (39.3%)  |
|Societal needs, values, interests and expectations                               |5 (3.4%)    |30 (20.3%)                 |113 (76.4%) |


![](02_descriptives_parts_c_d_files/figure-html/d7-1.png)<!-- -->
