# This config file loads neccisary packages and data for perioperative analysis.

# Author: Chris LeBoa
# Version: 2021-11-11

# Libraries
library(tidyverse)
library(tableone)
library(readxl)


# Parameters

data_location <- here::here("data/Humanitarian perioperative risk stratification tables_leboa_wild11162021.xlsx")
t2_output_location <- here::here("data/table_2.csv")
headers <- c("Demographics", "Injury/Pathology type", "Vitals/Labs", "Labs", "Urgency and Type of Surgery", "Comorbidities", "Outcomes")
tab_2_edited <- "/Users/ChrisLeBoa/GitHub/perioprative mortality risk/data/table_2.csv"

#===============================================================================

#Code

data_all <- read_excel(data_location, sheet = 1)  #reads in first sheet of data which is raw data pulled from review
data_presence <- read_excel(data_location, sheet = 2) #reads in sheet of which studies have certain data types
data_tab2 <- read_csv(tab_2_edited)

#Clean Data
data_presence_clean <-
  data_presence %>%    #Make data tidy -- put variables measured as columns instead of authors
  pivot_longer(cols = -...1, names_to = 'Author') %>%
  pivot_wider(names_from = ...1, values_from = value) %>%
  select(-headers) %>% #Remove header rows that had been included in dataset
  mutate_at(everything(.), "str_replace", "x", "1") %>% #Change all x's to 1's
  mutate_at(vars(-Author), "as.numeric") #make all columns except author numeric (https://stackoverflow.com/questions/44532888/exclude-columns-by-names-in-mutate-at-in-dplyr)


data_presence_clean$trauma
