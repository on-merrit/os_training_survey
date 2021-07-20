library(tidyverse)
# remotes::install_github("ikashnitsky/sjrdata")
library(sjrdata)

journals <- read_csv("data/processed/mag_journals_w_doaj.csv")

journals_with_issn <- journals %>%
  filter(!is.na(issn))

sjr <- sjr_journals %>%
  mutate(issn = if_else(str_detect(issn, "^-$"), NA_character_, issn))

sjr_issn <- sjr %>%
  distinct(issn, title) %>%
  separate(issn, c("issn1", "issn2"), remove = FALSE) %>%
  mutate(across(matches("issn\\d"),
                # adding something within a string
                # https://stackoverflow.com/a/13863762/3149349
                .fns = str_replace, "^(.{4})(.+)$", "\\1-\\2")) %>%
  rename(issn_sjr = issn)

journals %>%
  left_join(sjr_issn, by = c("issn" = "issn1"))
