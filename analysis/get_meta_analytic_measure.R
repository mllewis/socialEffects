# get meta-analytic effect size for each meta-analysis
library(here)
library(metafor)
library(tidyverse)


META_ANALYSIS_DATA_PATH <- here("data/raw/meta_analytic_data/meta-analysis-data-with-DOIS\ -\ hofmann2016.csv")
ma_data <- read_csv(META_ANALYSIS_DATA_PATH)


ma_data_no_missing_dois <- ma_data %>%
  filter(!is.na(doi))

var(ma_data_no_missing_dois$effect_size)
mean(ma_data_no_missing_dois$effect_size)


