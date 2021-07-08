library(targets)
library(tarchetypes)
source("R/functions.R")
source("R/helpers.R")
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("scales", "tidyverse", "visdat"))

list(
  tar_target(
    raw_data_file,
    "data/processed/survey_anonymised.csv",
    format = "file"
  ),
  tar_target(
    raw_data,
    read_csv(raw_data_file)
  ),
  tar_target(
    countries_file,
    "data/processed/countries_merged.csv",
    format = "file"
  ),
  tar_target(
    countries,
    read_csv(countries_file)
  ),
  tar_target(
    only_consenters,
    raw_data %>%
      remove_non_consenters()
  ),
  tar_target(
    with_countries,
    add_country(only_consenters, countries)
  ),
  tar_render(parts_a_b, "01_exploration.Rmd")
)
