# This script obtains the breakdown of job titles for each department
# and has a subsequent mapping for a field of study to create a weight column.


# libraries
library(tidyverse)
library(dplyr)
library(ggplot2)
library(googlesheets4)
library(stringr)

# You would need to replace this information with the breakdown
# of job titles and mapped educational background from your own 
# company

# for purpose of demonstration, this data set contains
# made up company departments, job titles, and mapped 
# field of studies
load("data/Company Demographics/company_field_weights.rda")
View(field_weights)

field_weights <- field_weights[2:8] %>% 
  rename(field_of_degree = 'Field of Study')

# Weight for each grouped department and field of degree
field_weights <- field_weights %>% 
  gather(key = "Department", value = "Weight", c(names(field_weights[1:6]))) %>% 
  as.data.frame() %>% 
  mutate(Weight = as.numeric(Weight)) %>% group_by(Department, field_of_degree) %>% 
  summarise(Weight = sum(Weight)) %>% 
  filter(field_of_degree != "NA")

View(field_weights)
