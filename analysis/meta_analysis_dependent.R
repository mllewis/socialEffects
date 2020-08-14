library(tidyverse)
library(dplyr)

data = read_csv("dep_var.csv")

filenames <- list.files(path = "data/raw/social_link/", pattern="*.csv", full.names=TRUE)

#looping through all files and getting mean closeness 
for (filename in filenames) {
  
  ma_data <- read_csv(filename)
  
  ma_data_closeness <- ma_data %>%
    select(Node, Closeness) 
  
  mn_clns = mean(ma_data_closeness$Closeness)
  
  data = add_row(data, study = filename, closeness = mn_clns)
}

write.csv(data, file = "C:\\Users\\Jailyn\\Documents\\dependent_output.csv")
