# get string for searching dois in web of science
library(tidyverse)
library(googlesheets4)

# in order get the googlesheets4 functions working properly you need
# to install it using the following command. If it doesn't work right away,
# try restarting RStudio.
#devtools::install_github("tidyverse/googlesheets4")

# key to spreadsheet with dois in them (merged)
FULL_DOI_SPREADSHEET <- "17IAiiTXifta4_yOpeRWj0YLa2AttBk2ORRwaHhK6e8E"

# this gets all the names of the worksheets in the spreadsheet
worksheets <- sheet_properties(FULL_DOI_SPREADSHEET) %>%
  pull(name)

# this defines a function that takes a worksheet name in the and spits out a string for searching
# dois in web of science
get_doi_string_for_wos<- function(worksheet_name, full_doi_spreadsheet){

  print(worksheet_name)
  manual_doi_data <- read_sheet(full_doi_spreadsheet, worksheet_name) %>%
    filter(doi != "NA") # remove all NA dois

  string = "DO = ("
  for (i in 1:length(manual_doi_data$doi)) {
    string = paste(string, manual_doi_data$doi[i], sep = " OR ")
  }
  print(string)
  print("=======")
}

# this is similiar to a for-loop. The first argument is a list of worksheet names (e.g. "hofmann2016"),
# the second argument is the name of the function (the one we defined above), and
# the thrid argument is the name of the spreadsheet that contains the dois
walk(worksheets,
     get_doi_string_for_wos,
     FULL_DOI_SPREADSHEET)

