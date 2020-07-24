# merge automatic and manual dois
library(tidyverse)
library(googlesheets4)

# in order get the googlesheets4 functions working properly you need
# to install it using the following command. If it doesn't work right away,
# try restarting RStudio.
#devtools::install_github("tidyverse/googlesheets4")

AUTOMATIC_DOI_SPREADSHEET <- "1yHl4OLSRJfEsdGDCe6m4tyn_Q-lXuUaA_-M_3MbWL3Y"
MANUAL_DOI_SPREADSHEET <- "1SM_aS8MFg5L-YQqud79L1XVNdDSMn0LkbGxZkJuSGXk"
OUTPUT_SPREADSHEET <- "17IAiiTXifta4_yOpeRWj0YLa2AttBk2ORRwaHhK6e8E"

# this gets all the names of the worksheets in the meta-analysis data spreadsheets
# jailyn's worksheets
automated_names <- sheet_properties(AUTOMATIC_DOI_SPREADSHEET) %>%
  pull(name)

# sarah's worksheets
manual_names <- sheet_properties(MANUAL_DOI_SPREADSHEET) %>%
  pull(name)

# this gets a list of ma worksheets that BOTH Sarah and Jailyn have completed
manual_and_automated_complete_names <- intersect(automated_names, manual_names)

# this defines a function that takes a worksheet name, reads in sarah's and jailyn's version,
# adds a new column (doi) that merges the two types of dois, and then saves the new worksheet to a new spreadsheet
# (https://docs.google.com/spreadsheets/d/17IAiiTXifta4_yOpeRWj0YLa2AttBk2ORRwaHhK6e8E/edit#gid=324060504)
get_merged_dfs <- function(worksheet_name, manual_doi, automated_doi, output_sheet){


  manual_doi_data <- read_sheet(manual_doi, worksheet_name) %>%
    select(study_short, doi_manual) %>%
    mutate(doi_manual = as.character(doi_manual))

  automatic_doi_data <- read_sheet(automated_doi, worksheet_name)

  merged_data <- automatic_doi_data %>%
    left_join(manual_doi_data) %>%
    mutate(doi = case_when(is.na(doi_automated) ~ doi_manual,
                           TRUE ~ doi_automated)) %>%
    select(-doi_manual, -doi_automated)

  sheet_write(merged_data, output_sheet, worksheet_name)

}

# this is similiar to a for-loop. The first argument is a list of worksheet names (e.g. "hofmann2016"),
# the second argument is the name of the function (the one we defined above), and the 3rd-5th arguments are the keys to
# the worksheets that we are reading and writing to
walk(manual_and_automated_complete_names,
       get_merged_dfs,
       MANUAL_DOI_SPREADSHEET,
       AUTOMATIC_DOI_SPREADSHEET,
       OUTPUT_SPREADSHEET)





string = "DO = ("
for (i in 1:length(automatic_doi_data$doi_automated)) {
  string = paste(string, automatic_doi_data$doi_automated[i], sep = " OR ")
}
