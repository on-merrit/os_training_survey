library(targets)
library(tarchetypes)
# need to set encodings to handle " ' " characters:
# https://stackoverflow.com/a/41747709/3149349
source("R/functions.R", encoding = "UTF-8")
source("R/helpers.R", encoding = "UTF-8")
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("scales", "tidyverse", "visdat", "patchwork"))

list(
  tar_target(
    raw_data_file,
    "data/processed/survey_anonymised.csv",
    format = "file"
  ),  
  tar_target(
    label_base,
    "data/label_base.csv",
    format = "file"
  ),
  tar_target(
    var_overview,
    create_var_overview(label_base)
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
  tar_render(parts_a_b, "01_descriptives_parts_a_b.Rmd"),
  tar_render(parts_c_d, "02_descriptives_parts_c_d.Rmd")
)

