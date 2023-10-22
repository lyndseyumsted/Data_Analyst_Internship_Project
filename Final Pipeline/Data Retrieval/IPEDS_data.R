# This script filters and cleans the IPEDS C20XX_A Data 
# groups and variables of interest.


# The cipcodes are loaded 


# Data pulled from: https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?gotoReportId=7&fromIpeds=true
# need to download the .csv files for the years you want

# libraries
library(tidyverse)
library(censusapi)
library(dplyr)
library(ggplot2)
library(stringr)
library(googlesheets4)
library(purrr)

# using filtered cipcodes
load("data/IPEDS data/filtered_cip_codes.rda")

# retrieving data files
  # Add 2022 when available

# 2021 data
IPEDS_data_2021 <- read.csv("data/IPEDS data/c2021_a.csv")
# 2020 data
IPEDS_data_2020 <- read.csv("data/IPEDS data/c2020_a.csv")
# 2019 data
IPEDS_data_2019 <- read.csv("data/IPEDS data/c2019_a.csv")
# 2018 data
IPEDS_data_2018 <- read.csv("data/IPEDS data/c2018_a.csv")
# 2017 data
IPEDS_data_2017 <- read.csv("data/IPEDS data/c2017_a.csv")
# 2016 data
IPEDS_data_2016 <- read.csv("data/IPEDS data/c2016_a.csv")
# 2015 data
IPEDS_data_2015 <- read.csv("data/IPEDS data/c2015_a.csv")
# 2014 data
IPEDS_data_2014 <- read.csv("data/IPEDS data/c2014_a.csv")
# 2013 data
IPEDS_data_2013 <- read.csv("data/IPEDS data/c2013_a.csv")
# 2012 data
IPEDS_data_2012 <- read.csv("data/IPEDS data/c2012_a.csv")


# function for initial filtering of data frames
data_filter <- function(x){
  return (as.data.frame(x[c(1,2,3,6,8,10,14,16,20,22,26,28,32,34,38,40,44,46,50,52,56,58)] %>% # variables of interest
                          mutate(CIPCODE = as.character(CIPCODE)) %>% # turn to type character for future use
                          filter(CIPCODE %in% cip_codes) %>% # filtering for specific CIPCODES
                          # renaming variables for more readability
                          filter(MAJORNUM == 1) %>% 
                          rename(institude_id = UNITID, # institude id
                                 field_of_degree = CIPCODE, # Major field of study
                                 major = MAJORNUM, # first or second major
                                 total = CTOTALT, # total
                                 total_m = CTOTALM, # total men
                                 total_f = CTOTALW, # total women
                                 ai_an_m = CAIANM, # American Indian/Alaska Native Men
                                 ai_an_f = CAIANW, # American Indian/Alaska Native Women
                                 asian_m = CASIAM, # Asian Men
                                 asian_f = CASIAW, # Asian Women
                                 black_m = CBKAAM, # Black Men
                                 black_f = CBKAAW, # Black Women
                                 hispanic_m = CHISPM, # Hispanic Men
                                 hispanic_f = CHISPW, # Hispanic Women
                                 hawaiian_pi_m = CNHPIM, # Native Hawaiian/Other Pacific Islander Men
                                 hawaiian_pi_f = CNHPIW, # Native Hawaiian/Other Pacific Islander Women
                                 white_m = CWHITM, # White Men
                                 white_f = CWHITW, # White Women
                                 multiple_race_m = C2MORM, # 2 or more race men
                                 multiple_race_f = C2MORW, # 2 or more races women
                                 unknown_m = CUNKNM, # unknown men
                                 unknown_f = CUNKNW # unknown women
                          ))) 
}

# 2012 data variables slightly different
IPEDS_data_2012 <- as.data.frame(IPEDS_data_2012[c(1,2,3,7,9,11,15,17,21,23,27,29,33,35,39,41,45,47,51,53,57,59)] %>% # variables of interest
                                   mutate(CIPCODE = as.character(CIPCODE)) %>% # turn to type character for future use
                                   filter(CIPCODE %in% cip_codes) %>% # filtering for specific CIPCODES
                                   # renaming variables for more readability
                                   filter(MAJORNUM == 1) %>%
                                   rename(institude_id = UNITID, # institude id
                                          field_of_degree = CIPCODE, # Major field of study
                                          major = MAJORNUM, # first or second major
                                          total = CTOTALT, # total
                                          total_m = CTOTALM, # total men
                                          total_f = CTOTALW, # total women
                                          ai_an_m = CAIANM, # American Indian/Alaska Native Men
                                          ai_an_f = CAIANW, # American Indian/Alaska Native Women
                                          asian_m = CASIAM, # Asian Men
                                          asian_f = CASIAW, # Asian Women
                                          black_m = CBKAAM, # Black Men
                                          black_f = CBKAAW, # Black Women
                                          hispanic_m = CHISPM, # Hispanic Men
                                          hispanic_f = CHISPW, # Hispanic Women
                                          hawaiian_pi_m = CNHPIM, # Native Hawaiian/Other Pacific Islander Men
                                          hawaiian_pi_f = CNHPIW, # Native Hawaiian/Other Pacific Islander Women
                                          white_m = CWHITM, # White Men
                                          white_f = CWHITW, # White Women
                                          multiple_race_m = C2MORM, # 2 or more race men
                                          multiple_race_f = C2MORW, # 2 or more races women
                                          unknown_m = CUNKNM, # unknown men
                                          unknown_f = CUNKNW # unknown women
                                   ))
IPEDS_data_2012$year <- 2012

# applying filtering function to the data from years 2013-2021 (ADD 2022 WHEN AVAILABLE)

IPEDS <- list(IPEDS_data_2013, IPEDS_data_2014, IPEDS_data_2015, IPEDS_data_2016, 
              IPEDS_data_2017, IPEDS_data_2018, IPEDS_data_2019, IPEDS_data_2020, IPEDS_data_2021) %>% 
  map(data_filter)

# retrieving each separate data set, assigning year variable, and reading to Google Sheets accessed in data_reading.R
  # Add 2022 when available, run, comment out after

IPEDS_data_2013 <- IPEDS[[1]]
IPEDS_data_2013$year <- 2013

IPEDS_data_2014 <- IPEDS[[2]]
IPEDS_data_2014$year <- 2014

IPEDS_data_2015 <- IPEDS[[3]]
IPEDS_data_2015$year <- 2015

IPEDS_data_2016 <- IPEDS[[4]]
IPEDS_data_2016$year <- 2016

IPEDS_data_2017 <- IPEDS[[5]]
IPEDS_data_2017$year <- 2017

IPEDS_data_2018 <- IPEDS[[6]]
IPEDS_data_2018$year <- 2018

IPEDS_data_2019 <- IPEDS[[7]]
IPEDS_data_2019$year <- 2019

IPEDS_data_2020 <- IPEDS[[8]]
IPEDS_data_2020$year <- 2020

IPEDS_data_2021 <- IPEDS[[9]]
IPEDS_data_2021$year <- 2021

# aggregating data
IPEDS_data <- bind_rows(list(IPEDS_data_2021, IPEDS_data_2020, IPEDS_data_2019, IPEDS_data_2018,
                             IPEDS_data_2017, IPEDS_data_2016, IPEDS_data_2015, IPEDS_data_2014,
                             IPEDS_data_2013, IPEDS_data_2012))

# save the aggregated data to a data folder
save(IPEDS_data, file = "data/IPEDS data/IPEDS_data.rda")

