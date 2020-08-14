# get meta-analytic effect size for each meta-analysis
library(metafor)
library(tidyverse)
library(readxl)
library(dplyr)

data = read_csv("in_var.csv")

filenames <- list.files(path = "data/raw/meta_analytic_data/", pattern="*.xlsx", full.names=TRUE)

#looping through all files and getting means and variability 
for (filename in filenames) {

  ma_data <- read_excel(filename)

  ma_data_no_missing_dois <- ma_data %>%
    filter(!is.na(doi)) %>% 
    filter(!is.na(effect_size))

  vr = var(ma_data_no_missing_dois$effect_size)
  mn = mean(ma_data_no_missing_dois$effect_size)
  
  data = add_row(data, study = filename, mean = mn, var = vr)
}

write.csv(data, file = "C:\\Users\\Jailyn\\Documents\\independent_output.csv")