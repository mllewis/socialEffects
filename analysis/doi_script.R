library(readxl)
library(tidyverse)

hoffman2016_data = read_excel("hoffman2016_data.xlsx")
#piping wasn't working for some reason
hoffman_doi = select(hoffman2016_data, study_long)  

hoffman_doi = separate(hoffman_doi, study_long, c("study", "doi"), sep = "http://dx.doi.org/")

hoffman_doi = separate(hoffman_doi, doi , c("doi", "pubmed"), sep = " ")

hoffman_doi = separate(hoffman_doi, doi , c("doi", "NA"), sep = -1)

hoffman_doi = select(hoffman_doi, study, doi)

OUTPATH = "C:/Users/Jailyn/Documents/Papers/hofmann_doi.csv"

write_csv(hoffman_doi, OUTPATH)

