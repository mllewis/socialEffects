library(tabulizer)
library(tidyverse)

PAPER_PATH <- "/Users/mollylewis/Desktop/nihms754207.pdf"

tab <- extract_tables(PAPER_PATH,
                      pages = 24, 
                      columns = list(4),
                      output = "data.frame")

full_table <- tab[[1]]


