
# This script is used to establish the Fields of Interest for the company's
# Employees in each area/department and filters for Fields of Interest from the IPEDS Data set.

# Below is a map
    # The google sheet contains all documentation on the IPEDS C2021_A Table.
        # CIPCODE (Classification of Instructional Program Code) is the variable which maps
        # to a program/major/degree from a postsecondary school and is the same for all years.

# Codevalue is a number and valueLabel is the matching program/major/degree
# Example: Codevalue 14.01 is valueLabel "Engineering, General"

# Data dictionary pulled from: https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?gotoReportId=7&fromIpeds=true


# libraries
library(tidyverse)
library(dplyr)
library(stringr)

# data
load("data/IPEDS data/cipcode_vals.rda")

# this is where I filter for fields of study I find relevant to the company
cipcode_vals <- cipcode_vals %>% 
  filter(varname == "CIPCODE") %>% # only want to look at CIPCODE variable values and labels
  select(c("codevalue", "valuelabel")) %>%  # number and corresponding program/major/degree
  filter(str_detect(valuelabel, "Math|Computer Engineering|Econ|Business|Accounting|Finance|Statistic|Comput|Software|Communications|Data|Management|Marketing|Psych|Sociology|Analytics|Law|Legal|Technology|Information|Actuar")) %>% # relevant areas of study
  filter(!str_detect(valuelabel, "Horti|Agri|Bio|Chem|Fami|Food|Farm|Irrigation|Plant|Livestock|Environ|Land|Water|Fish|Flori|Animal|Forest|Wild|Wood|Vet|Husbandry|Green|grass|Archite")) # irrelevant areas of study still in the selection

cip_codes <- cipcode_vals$codevalue # creating a vector of relevant CIPCODE values

# save relevant CIPCODE values
save(cipcode_vals, file = "data/IPEDS data/filtered_cipcode_vals.rda")
save(cip_codes, file = "data/IPEDS data/filtered_cip_codes.rda")

