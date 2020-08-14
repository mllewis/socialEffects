library(tidyverse)
library(dplyr)
library(metafor)

ind = read.csv("C:\\Users\\Jailyn\\Documents\\independent_output.csv")
dep = read.csv("C:\\Users\\Jailyn\\Documents\\dependent_output.csv")

ind = separate(ind, study, c("path", "dash", "study"), sep = "([ ])") %>% 
  select(study, mean, var) %>% 
  separate(study, c("study"), sep = ".xlsx")

dep = separate(dep, study, c("blank", "study"), sep = "Network_") %>% 
  select(study, closeness) %>% 
  separate(study, c("study"), sep = ".csv")

full_table = left_join(ind, dep)

write.csv(full_table, file = "C:\\Users\\Jailyn\\Documents\\meta_correlation.csv")