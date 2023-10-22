

# OECD.Stat

library(devtools)

# install OECD package
devtools::install_version("OECD", version = "0.2.4", repos = "https://stat.ethz.ch/CRAN/")
# libraries
library(tidyr)
library(tidyverse)
library(censusapi)
library(dplyr)
library(ggplot2)
library(stringr)
library(googlesheets4)
library(purrr)
library(OECD)

# list of datasets from OECD
dataset_list <- get_datasets()
search_dataset("field of education", data = dataset_list)
dataset <- "EDU_GRAD_FIELD"

dstruc <- get_data_structure(dataset)
str(dstruc, max.level = 1)

# filter is the customized query, this is the query for my dummy company.
df <- get_dataset(dataset, filter = "AUS+AUT+BEL+CAN+CHL+COL+CZE+DNK+EST+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ISR+ITA+JPN+KOR+LVA+LTU+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+ESP+SWE+CHE+TUR+GBR+USA+NMEC+BRA.F+M.F03+F04+F05+F06+F07.ISCED11_35+ISCED11_45+ISCED11_5+ISCED11_6+ISCED11_645_646_655_656_665_66+ISCED11_7+ISCED11_746_756_766+ISCED11_8._T",
                  pre_formatted = TRUE)


oecd_df <- df %>% 
  select(c(COUNTRY, EDUCATION_FIELD, SEX, obsTime, obsValue)) %>% 
  rename(country = COUNTRY, # institude id
         field_of_degree = EDUCATION_FIELD, # Major field of study
         sex = SEX,
         time = obsTime,
         counts = obsValue
  ) %>% 
  mutate(field_of_degree = recode(field_of_degree,
                                  "F03" = "Psych/Sociology",
                                  "F04" = "Business",
                                  "F05" = "Business",
                                  "F06" = "Business",
                                  "F07" = "Computer Engineering")) %>% 
  mutate(sex = recode(sex,
                      "M" = "male",
                      "F" = "female")) %>% 
  filter(counts != "NaN")


EMEA <- c("AUT", "BEL", "CZE", "DNK", "EST", "FIN", 
          "FRA", "DEU", "GRC", "HUN", "ISL", "IRL", 
          "ISR", "ITA", "LVA", "LTU", "LUX", "NLD", 
          "NOR", "POL", "PRT", "SVK", "SVN", "ESP", 
          "SWE", "CHE", "TUR", "GBR", "RUS")
APAC <- c("AUS", "JPN", "KOR", "NZL")


EMEA_fields <- oecd_df %>% 
  filter(country %in% EMEA) %>% 
  group_by(field_of_degree, sex) %>% 
  summarise(counts = sum(counts)) 



APAC_fields <- oecd_df %>% 
  filter(country %in% APAC) %>% 
  group_by(field_of_degree, sex) %>% 
  summarise(counts = sum(counts))



