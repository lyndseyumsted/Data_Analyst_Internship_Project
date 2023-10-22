 

# This script updates a DEI Health Index Dashboard
# with up-to-date internal data and benchmarks from
# the IPEDS dataset using Google Sheets

require("httr")
library(httr)
library(dplyr)
library(tidyverse)
library(janitor)
library(googlesheets4)
library(scales)


# insights script to write updates to
# other google sheet before formatting them here for dashboards

source("Final Pipeline/DEI Automation/IPEDS_data_wrangle.R")

google_sheet <- "your Google Sheet URL here"

################################################################################

# WOMEN Dashboard Baseline

pct_gender <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal", "APAC", "EMEA"), 
                        Representation = c(all_departments_counts_gender[9,3], Engineering_counts_gender[9,3], 
                                              Marketing_counts_gender[9,3], Sales_counts_gender[9,3], HR_counts_gender[9,3], 
                                           Legal_counts_gender[9,3], region_1_counts[1,2], region_2_counts[1,2]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated gender representation from IPEDS
range_write(ss=google_sheet, data = pct_gender, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_gender, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


################################################################################


# POC Dashboard baseline

pct_poc <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                             Representation = 1- c(all_departments_counts_race[3,9], Engineering_counts_race[3,9], 
                                                Marketing_counts_race[3,9], Sales_counts_race[3,9], HR_counts_race[3,9],
                                                Legal_counts_race[3,9]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)



# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_poc, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_poc, sheet="representation", range="", col_names = FALSE, reformat = FALSE)



# WOC Dashboard

pct_woc <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                        Representation = 1- c(all_departments_counts_race[1,9], Engineering_counts_race[1,9], 
                                              Marketing_counts_race[1,9], Sales_counts_race[1,9], HR_counts_race[1,9], 
                                              Legal_counts_race[1,9]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated woc representation from IPEDS
range_write(ss=google_sheet, data = pct_woc, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_woc, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# MOC Dashboard
pct_moc <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                        Representation = 1- c(all_departments_counts_race[2,9], Engineering_counts_race[2,9], 
                                              Marketing_counts_race[2,9], Sales_counts_race[2,9], HR_counts_race[2,9],
                                              Legal_counts_race[2,9]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)


# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_moc, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_moc, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


################################################################################ 


## POC Groups

################################################################################

# American Indian/Alaskan Native Dashboard baseline
# Both sexes

pct_ai_an <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                            Representation = c(all_departments_counts_race[3,2], Engineering_counts_race[3,2], 
                                               Marketing_counts_race[3,2], Sales_counts_race[3,2], HR_counts_race[3,2],
                                               Legal_counts_race[3,2]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)


# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_ai_an, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_ai_an, sheet="representation", range="", col_names = FALSE, reformat = FALSE)

# women
pct_ai_an_women <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[1,2], Engineering_counts_race[1,2], 
                                             Marketing_counts_race[1,2], Sales_counts_race[1,2], HR_counts_race[1,2],
                                             Legal_counts_race[1,2]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)


# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_ai_an_women, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_ai_an_women, sheet="representation", range="", col_names = FALSE, reformat = FALSE)

# men
pct_ai_an_men <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[2,2], Engineering_counts_race[2,2], 
                                             Marketing_counts_race[2,2], Sales_counts_race[2,2], HR_counts_race[2,2],
                                             Legal_counts_race[2,2]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_ai_an_men, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_ai_an_men, sheet="representation", range="", col_names = FALSE, reformat = FALSE)

################################################################################


# Asian
pct_asian <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[3,3], Engineering_counts_race[3,3], 
                                             Marketing_counts_race[3,3], Sales_counts_race[3,3], HR_counts_race[3,3],
                                              Legal_counts_race[3,3]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_asian, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_asian, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# women
pct_asian_women <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[1,3], Engineering_counts_race[1,3], 
                                             Marketing_counts_race[1,3], Sales_counts_race[1,3], HR_counts_race[1,3],
                                              Legal_counts_race[1,3]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_asian_women, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_asian_women, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# men
pct_asian_men <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[2,3], Engineering_counts_race[2,3], 
                                             Marketing_counts_race[2,3], Sales_counts_race[2,3], HR_counts_race[2,3],
                                              Legal_counts_race[2,3]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_asian_men, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_asian_men, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


################################################################################


# Black
pct_black <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[3,4], Engineering_counts_race[3,4], 
                                             Marketing_counts_race[3,4], Sales_counts_race[3,4], HR_counts_race[3,4],
                                              Legal_counts_race[3,4]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_black, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_black, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# women
pct_black_women <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[1,4], Engineering_counts_race[1,4], 
                                             Marketing_counts_race[1,4], Sales_counts_race[1,4], HR_counts_race[1,4],
                                              Legal_counts_race[1,4]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_black_women, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_black_women, sheet="representation", range="", col_names = FALSE, reformat = FALSE)

# men
pct_black_men <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[2,4], Engineering_counts_race[2,4], 
                                             Marketing_counts_race[2,4], Sales_counts_race[2,4], HR_counts_race[2,4],
                                              Legal_counts_race[2,4]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_black_men, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_black_men, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


################################################################################


# hispanic

pct_hispanic <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[3,6], Engineering_counts_race[3,6], 
                                             Marketing_counts_race[3,6], Sales_counts_race[3,6], HR_counts_race[3,6],
                                              Legal_counts_race[3,6]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_hispanic, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_hispanic, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# women
pct_hispanic_women <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                             Representation = c(all_departments_counts_race[1,6], Engineering_counts_race[1,6], 
                                                Marketing_counts_race[1,6], Sales_counts_race[1,6], HR_counts_race[1,6],
                                                 Legal_counts_race[1,6]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_hispanic_women, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_hispanic_women, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# men
pct_hispanic_men <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                             Representation = c(all_departments_counts_race[2,6], Engineering_counts_race[2,6], 
                                                Marketing_counts_race[2,6], Sales_counts_race[2,6], HR_counts_race[2,6],
                                                 Legal_counts_race[2,6]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_hispanic_men, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_hispanic_men, sheet="representation", range="", col_names = FALSE, reformat = FALSE)



################################################################################


# multiple_races
pct_multiple <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                             Representation = c(all_departments_counts_race[3,7], Engineering_counts_race[3,7], 
                                                Marketing_counts_race[3,7], Sales_counts_race[3,7], HR_counts_race[3,7],
                                                 Legal_counts_race[3,7]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_multiple, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_multiple, sheet="representation", range="", col_names = FALSE, reformat = FALSE)

# women
pct_multiple_women <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                             Representation = c(all_departments_counts_race[1,7], Engineering_counts_race[1,7], 
                                                Marketing_counts_race[1,7], Sales_counts_race[1,7], HR_counts_race[1,7],
                                                 Legal_counts_race[1,7]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_multiple_women, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_multiple_women, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# men
pct_multiple_men <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                             Representation = c(all_departments_counts_race[2,7], Engineering_counts_race[2,7], 
                                                Marketing_counts_race[2,7], Sales_counts_race[2,7], HR_counts_race[2,7],
                                                 Legal_counts_race[2,7]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_multiple_men, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_multiple_men, sheet="representation", range="", col_names = FALSE, reformat = FALSE)



################################################################################


# hawaiian
pct_hawaiian <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                             Representation = c(all_departments_counts_race[3,5], Engineering_counts_race[3,5], 
                                                Marketing_counts_race[3,5], Sales_counts_race[3,5], HR_counts_race[3,5],
                                                 Legal_counts_race[3,5]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_hawaiian, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_hawaiian, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# women

pct_hawaiian_women <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                             Representation = c(all_departments_counts_race[1,5], Engineering_counts_race[1,5], 
                                                Marketing_counts_race[1,5], Sales_counts_race[1,5], HR_counts_race[1,5],
                                                 Legal_counts_race[1,5]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_hawaiian_women, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_hawaiian_women, sheet="representation", range="", col_names = FALSE, reformat = FALSE)



# men

pct_hawaiian_men <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                             Representation = c(all_departments_counts_race[2,5], Engineering_counts_race[2,5], 
                                                Marketing_counts_race[2,5], Sales_counts_race[2,5], HR_counts_race[2,5],
                                                 Legal_counts_race[2,5]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_hawaiian_men, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_hawaiian_men, sheet="representation", range="", col_names = FALSE, reformat = FALSE)



################################################################################



# white
pct_white <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                        Representation = c(all_departments_counts_race[3,9], Engineering_counts_race[3,9], 
                                           Marketing_counts_race[3,9], Sales_counts_race[3,9], HR_counts_race[3,9],
                                            Legal_counts_race[3,9]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_white, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_white, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# women

pct_white_women <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[1,9], Engineering_counts_race[1,9], 
                                             Marketing_counts_race[1,9], Sales_counts_race[1,9], HR_counts_race[1,9],
                                              Legal_counts_race[1,9]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_white_women, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_white_women, sheet="representation", range="", col_names = FALSE, reformat = FALSE)



# men

pct_white_men <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[2,9], Engineering_counts_race[2,9], 
                                             Marketing_counts_race[2,9], Sales_counts_race[2,9], HR_counts_race[2,9],
                                              Legal_counts_race[2,9]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_white_men, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_white_men, sheet="representation", range="", col_names = FALSE, reformat = FALSE)



################################################################################


# unknown
pct_unknown <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                          Representation = c(all_departments_counts_race[3,8], Engineering_counts_race[3,8], 
                                             Marketing_counts_race[3,8], Sales_counts_race[3,8], HR_counts_race[3,8],
                                              Legal_counts_race[3,8]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_unknown, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_unknown, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# women

pct_unknown_women <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                            Representation = c(all_departments_counts_race[1,8], Engineering_counts_race[1,8], 
                                               Marketing_counts_race[1,8], Sales_counts_race[1,8], HR_counts_race[1,8],
                                                Legal_counts_race[1,8]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_unknown_women, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_unknown_women, sheet="representation", range="", col_names = FALSE, reformat = FALSE)


# men
pct_unknown_men <- t(data.frame(Department = c("Overall", "Engineering", "Marketing", "Sales", "Human Resources", "Legal"), 
                            Representation = c(all_departments_counts_race[2,8], Engineering_counts_race[2,8], 
                                               Marketing_counts_race[2,8], Sales_counts_race[2,8], HR_counts_race[2,8],
                                                Legal_counts_race[2,8]))) %>% 
  row_to_names(row_number = 1) %>% 
  as.data.frame() %>% 
  mutate_if(is.character, as.numeric)

# writing in updated poc representation from IPEDS
range_write(ss=google_sheet, data = pct_unknown_men, sheet="DHI Dashboard", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = pct_unknown_men, sheet="representation", range="", col_names = FALSE, reformat = FALSE)




################################################################################




# INTERNAL DATA ON ETHNICITY AND GENDER

# This is where you would retrieve the demographics for each group 
# in the company you are assessing. 
# I included 4 "factors" these would be areas in each 
# department you would like to assess

# made up internal representation of groups 

# representation of women
load("data/Company Demographics/gender_df.rda")

# representation of people of color
load("data/Company Demographics/poc_df.rda")
# women of color
load("data/Company Demographics/woc_df.rda")
# men of color
load("data/Company Demographics/moc_df.rda")

# American Indian or Alaska Native
load("data/Company Demographics/ai_an_df.rda")
load("data/Company Demographics/ai_an_df_women.rda")
load("data/Company Demographics/ai_an_df_men.rda")

load("data/Company Demographics/asian_df.rda")
load("data/Company Demographics/asian_df_women.rda")
load("data/Company Demographics/asian_df_men.rda")

# Black or African American
load("data/Company Demographics/black_df.rda")
load("data/Company Demographics/black_df_women.rda")
load("data/Company Demographics/black_df_men.rda")

# Hispanic or Latinx
load("data/Company Demographics/hispanic_df.rda")
load("data/Company Demographics/hispanic_df_women.rda")
load("data/Company Demographics/hispanic_df_men.rda")

# Multiple Races
load("data/Company Demographics/multiple_df.rda")
load("data/Company Demographics/multiple_df_women.rda")
load("data/Company Demographics/multiple_df_men.rda")

# Native Hawaiian or Pacific Islander
load("data/Company Demographics/hawaiian_df.rda")
load("data/Company Demographics/hawaiian_df_women.rda")
load("data/Company Demographics/hawaiian_df_men.rda")

# Unknown 
load("data/Company Demographics/unknown_df.rda")
load("data/Company Demographics/unknown_df_women.rda")
load("data/Company Demographics/unknown_df_men.rda")

# White
load("data/Company Demographics/white_df.rda")
load("data/Company Demographics/white_df_women.rda")
load("data/Company Demographics/white_df_men.rda")




row.names(gender_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(poc_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(woc_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(moc_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(ai_an_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(ai_an_df_women) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(ai_an_df_men) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(black_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(black_df_women) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(black_df_men) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(asian_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(asian_df_women) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(asian_df_men) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(hispanic_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(hispanic_df_women) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(hispanic_df_men) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(multiple_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(multiple_df_women) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(multiple_df_men) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(hawaiian_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(hawaiian_df_women) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(hawaiian_df_men) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(unknown_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(unknown_df_women) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(unknown_df_men) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(white_df) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(white_df_women) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")
row.names(white_df_men) <- c("Current Representation", "Factor 1", "Factor 2", "Factor 3", "Factor 4")

gender_df <- gender_df %>% 
  rename("APAC" = APAC,
         "EMEA" = EMEA)

save(gender_df, file = "data/Company Demographics/gender_df.rda")

# representation of people of color
save(poc_df, file = "data/Company Demographics/poc_df.rda")
# women of color
save(woc_df, file = "data/Company Demographics/woc_df.rda")
# men of color
save(moc_df, file = "data/Company Demographics/moc_df.rda")

# American Indian or Alaska Native
save(ai_an_df, file = "data/Company Demographics/ai_an_df.rda")
save(ai_an_df_women, file = "data/Company Demographics/ai_an_df_women.rda")
save(ai_an_df_men, file = "data/Company Demographics/ai_an_df_men.rda")

save(asian_df, file = "data/Company Demographics/asian_df.rda")
save(asian_df_women, file = "data/Company Demographics/asian_df_women.rda")
save(asian_df_men, file = "data/Company Demographics/asian_df_men.rda")

# Black or African American
save(black_df, file = "data/Company Demographics/black_df.rda")
save(black_df_women, file = "data/Company Demographics/black_df_women.rda")
save(black_df_men, file = "data/Company Demographics/black_df_men.rda")

# Hispanic or Latinx
save(hispanic_df, file = "data/Company Demographics/hispanic_df.rda")
save(hispanic_df_women, file = "data/Company Demographics/hispanic_df_women.rda")
save(hispanic_df_men, file = "data/Company Demographics/hispanic_df_men.rda")

# Multiple Races
save(multiple_df, file = "data/Company Demographics/multiple_df.rda")
save(multiple_df_women, file = "data/Company Demographics/multiple_df_women.rda")
save(multiple_df_men, file = "data/Company Demographics/multiple_df_men.rda")

# Native Hawaiian or Pacific Islander
save(hawaiian_df, file = "data/Company Demographics/hawaiian_df.rda")
save(hawaiian_df_women, file = "data/Company Demographics/hawaiian_df_women.rda")
save(hawaiian_df_men, file = "data/Company Demographics/hawaiian_df_men.rda")

# Unknown 
save(unknown_df, file = "data/Company Demographics/unknown_df.rda")
save(unknown_df_women, file = "data/Company Demographics/unknown_df_women.rda")
save(unknown_df_men, file = "data/Company Demographics/unknown_df_men.rda")

# White
save(white_df, file = "data/Company Demographics/white_df.rda")
save(white_df_women, file = "data/Company Demographics/white_df_women.rda")
save(white_df_men, file = "data/Company Demographics/white_df_men.rda")

################################################################################

# writing interal percentages to Google Sheet Dashboard and pct_looker sheet
# used for dynamic dashboard in looker studio



range_write(ss=google_sheet, data = poc_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = poc_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = gender_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = gender_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = ai_an_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = ai_an_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = asian_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = asian_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = black_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = black_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = hispanic_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = hispanic_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = multiple_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = multiple_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = hawaiian_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = hawaiian_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = unknown_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = unknown_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = white_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = white_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)



# women
range_write(ss=google_sheet, data = woc_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = woc_df, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = ai_an_df_women, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = ai_an_df_women, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = asian_df_women, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = asian_df_women, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = black_df_women, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = black_df_women, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = hispanic_df_women, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = hispanic_df_women, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = multiple_df_women, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = multiple_df_women, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = hawaiian_df_women, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = hawaiian_df_women, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = unknown_df_women, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = unknown_df_women, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = white_df_women, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = white_df_women, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)


# men
range_write(ss=google_sheet, data = moc_df, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = moc_df, sheet="pct_looker", range="E117", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = ai_an_df_men, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = ai_an_df_men, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = asian_df_men, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = asian_df_men, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = black_df_men, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = black_df_men, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = hispanic_df_men, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = hispanic_df_men, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = multiple_df_men, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = multiple_df_men, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = hawaiian_df_men, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = hawaiian_df_men, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = unknown_df_men, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = unknown_df_men, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)

range_write(ss=google_sheet, data = white_df_men, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = white_df_men, sheet="pct_looker", range="", col_names = FALSE, reformat = FALSE)


################################################################################


# DEI Index Score for pct_looker sheet:


dei_scores <- function(df1, df2) {
  current_and_baseline = bind_rows(list(df1, df2[-1,]))
  current_and_baseline[2,] = current_and_baseline[2,]/current_and_baseline[1,]
  current_and_baseline[3,] = current_and_baseline[3,]/current_and_baseline[1,]
  current_and_baseline[4,] = current_and_baseline[4,]/current_and_baseline[1,]
  current_and_baseline[5,] = current_and_baseline[1,]/current_and_baseline[5,]
  current_and_baseline = current_and_baseline[-1,] 
  current_and_baseline[sapply(current_and_baseline, is.infinite)] = NA
  return (current_and_baseline)
}

# Women

women_representation <- bind_rows(list(pct_gender, gender_df))
women_representation$area <- c("Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(women_representation, file = "data/Comparison data/women_comparison.rda")
women_dei_score <- dei_scores(pct_gender, gender_df)
range_write(ss=google_sheet, data = women_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

women_dei_score$area <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(women_dei_score, file = "data/Comparison data/women_comparison_scores.rda")


# POC
poc_representation <- bind_rows(list(pct_poc, poc_df))
poc_dei_score <- dei_scores(pct_poc, poc_df)

range_write(ss=google_sheet, data = poc_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

poc_representation$group <- "both sexes"
poc_dei_score$group <- "both sexes"


# women of color
woc_representation <- bind_rows(list(pct_woc, woc_df))
woc_dei_score <- dei_scores(pct_woc, woc_df)

range_write(ss=google_sheet, data = woc_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

woc_representation$group <- "women"
woc_dei_score$group <- "women"

# men of color
moc_representation <- bind_rows(list(pct_moc, moc_df))
moc_dei_score <- dei_scores(pct_moc, moc_df)

range_write(ss=google_sheet, data = moc_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

moc_representation$group <- "men"
moc_dei_score$group <- "men"

poc_representation <- bind_rows(poc_representation, woc_representation, moc_representation)
poc_representation$area <- c("Baseline Representation", "Current Representation", 
                             "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                             "Baseline Representation", "Current Representation", 
                             "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                             "Baseline Representation", "Current Representation", 
                             "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(poc_representation, file = "data/Comparison data/poc_comparison.rda")

poc_dei_score <- bind_rows(poc_dei_score, woc_dei_score, moc_dei_score)
poc_dei_score$group <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4",
                         "Factor 1", "Factor 2", "Factor 3", "Factor 4",
                         "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(poc_dei_score, file = "data/Comparison data/poc_comparison_scores.rda")


# American Indian or Alaska Native
ai_an_representation <- bind_rows(list(pct_ai_an, ai_an_df))
ai_an_dei_score <- dei_scores(pct_ai_an, ai_an_df)

range_write(ss=google_sheet, data = ai_an_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

ai_an_representation$group <- "both sexes"
ai_an_dei_score$group <- "both sexes"

# women

ai_an_women_representation <- bind_rows(list(pct_ai_an_women, ai_an_df_women))
ai_an_women_dei_score <- dei_scores(pct_ai_an_women, ai_an_df_women)

range_write(ss=google_sheet, data = ai_an_women_dei_score, sheet="DEI Health Index Scores", range="E57", col_names = FALSE, reformat = FALSE)

ai_an_women_representation$group <- "women"
ai_an_women_dei_score$group <- "women"

# men
ai_an_men_representation <- bind_rows(list(pct_ai_an_men, ai_an_df_men))
ai_an_men_dei_score <- dei_scores(pct_ai_an_men, ai_an_df_men)

range_write(ss=google_sheet, data = ai_an_men_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

ai_an_men_representation$group <- "men"
ai_an_men_dei_score$group <- "men"

ai_an_representation <- bind_rows(ai_an_representation, ai_an_women_representation, ai_an_men_representation)
ai_an_representation$area <- c("Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                               "Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                               "Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(ai_an_representation, file = "data/Comparison data/ai_an_comparison.rda")

ai_an_dei_score <- bind_rows(ai_an_dei_score, ai_an_women_dei_score, ai_an_men_dei_score)
ai_an_dei_score$group <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4",
                           "Factor 1", "Factor 2", "Factor 3", "Factor 4",
                           "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(ai_an_dei_score, file = "data/Comparison data/ai_an_comparison_scores.rda")

# Asian
asian_representation <- bind_rows(list(pct_asian, asian_df))
asian_dei_score <- dei_scores(pct_asian, asian_df)

range_write(ss=google_sheet, data = asian_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

asian_representation$group <- "both sexes"
asian_dei_score$group <- "both sexes"

# women
asian_women_representation <- bind_rows(list(pct_asian_women, asian_df_women))
asian_women_dei_score <- dei_scores(pct_asian_women, asian_df_women)

range_write(ss=google_sheet, data = asian_women_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

asian_women_representation$group <- "women"
asian_women_dei_score$group <- "women"

# men
asian_men_representation <- bind_rows(list(pct_asian_men, asian_df_men))
asian_men_dei_score <- dei_scores(pct_asian_men, asian_df_men)

range_write(ss=google_sheet, data = asian_men_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

asian_men_representation$group <- "men"
asian_men_dei_score$group <- "men"

asian_representation <- bind_rows(asian_representation, asian_women_representation, asian_men_representation)
asian_representation$area <- c("Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                               "Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                               "Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(asian_representation, file = "data/Comparison data/asian_comparison.rda")

asian_dei_score <- bind_rows(asian_dei_score, asian_women_dei_score, asian_men_dei_score)
asian_dei_score$group <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4",
                           "Factor 1", "Factor 2", "Factor 3", "Factor 4",
                           "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(asian_dei_score, file = "data/Comparison data/asian_comparison_scores.rda")

# Black
black_representation <- bind_rows(list(pct_black, black_df))
black_dei_score <- dei_scores(pct_black, black_df)

range_write(ss=google_sheet, data = black_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

black_representation$group <- "both sexes"
black_dei_score$group <- "both sexes"

# women
black_women_representation <- bind_rows(list(pct_black_women, black_df_women))
black_women_dei_score <- dei_scores(pct_black_women, black_df_women)

range_write(ss=google_sheet, data = black_women_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

black_women_representation$group <- "women"
black_women_dei_score$group <- "women"

# men
black_men_representation <- bind_rows(list(pct_black_men, black_df_men))
black_men_dei_score <- dei_scores(pct_black_men, black_df_men)

range_write(ss=google_sheet, data = black_men_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

black_men_representation$group <- "men"
black_men_dei_score$group <- "men"

black_representation <- bind_rows(black_representation, black_women_representation, black_men_representation)
black_representation$area <- c("Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                               "Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                               "Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(black_representation, file = "data/Comparison data/black_comparison.rda")

black_dei_score <- bind_rows(black_dei_score, black_women_dei_score, black_men_dei_score)
black_dei_score$group <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4",
                           "Factor 1", "Factor 2", "Factor 3", "Factor 4",
                           "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(black_dei_score, file = "data/Comparison data/black_comparison_scores.rda")

# Hispanic
hispanic_representation <- bind_rows(list(pct_hispanic, hispanic_df))
hispanic_dei_score <- dei_scores(pct_hispanic, hispanic_df)

range_write(ss=google_sheet, data = hispanic_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

hispanic_representation$group <- "both sexes"
hispanic_dei_score$group <- "both sexes"

# women
hispanic_women_representation <- bind_rows(list(pct_hispanic_women, hispanic_df_women))
hispanic_women_dei_score <- dei_scores(pct_hispanic_women, hispanic_df_women)

range_write(ss=google_sheet, data = hispanic_women_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

hispanic_women_representation$group <- "women"
hispanic_women_dei_score$group <- "women"

# men
hispanic_men_representation <- bind_rows(list(pct_hispanic_men, hispanic_df_men))
hispanic_men_dei_score <- dei_scores(pct_hispanic_men, hispanic_df_men)

range_write(ss=google_sheet, data = hispanic_men_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

hispanic_men_representation$group <- "men"
hispanic_men_dei_score$group <- "men"

hispanic_representation <- bind_rows(hispanic_representation, hispanic_women_representation, hispanic_men_representation)
hispanic_representation$area <- c("Baseline Representation", "Current Representation", 
                                  "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                                  "Baseline Representation", "Current Representation", 
                                  "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                                  "Baseline Representation", "Current Representation", 
                                  "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(hispanic_representation, file = "data/Comparison data/hispanic_comparison.rda")

hispanic_dei_score <- bind_rows(hispanic_dei_score, hispanic_women_dei_score, hispanic_men_dei_score)
hispanic_dei_score$group <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4",
                              "Factor 1", "Factor 2", "Factor 3", "Factor 4",
                              "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(hispanic_dei_score, file = "data/Comparison data/hispanic_comparison_scores.rda")




# multiple
multiple_representation <- bind_rows(list(pct_multiple, multiple_df))
multiple_dei_score <- dei_scores(pct_multiple, multiple_df)

range_write(ss=google_sheet, data = multiple_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

multiple_representation$group <- "both sexes"
multiple_dei_score$group <- "both sexes"

# women
multiple_women_representation <- bind_rows(list(pct_multiple_women, multiple_df_women))
multiple_women_dei_score <- dei_scores(pct_multiple_women, multiple_df_women)

range_write(ss=google_sheet, data = multiple_women_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

multiple_women_representation$group <- "women"
multiple_women_dei_score$group <- "women"

# men
multiple_men_representation <- bind_rows(list(pct_multiple_men, multiple_df_men))
multiple_men_dei_score <- dei_scores(pct_multiple_men, multiple_df_men)

range_write(ss=google_sheet, data = multiple_men_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

multiple_men_representation$group <- "men"
multiple_men_dei_score$group <- "men"

multiple_representation <- bind_rows(multiple_representation, multiple_women_representation, multiple_men_representation)
multiple_representation$area <- c("Baseline Representation", "Current Representation", 
                                  "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                                  "Baseline Representation", "Current Representation", 
                                  "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                                  "Baseline Representation", "Current Representation", 
                                  "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(multiple_representation, file = "data/Comparison data/multiple_comparison.rda")

multiple_dei_score <- bind_rows(multiple_dei_score, multiple_women_dei_score, multiple_men_dei_score)
multiple_dei_score$group <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4",
                              "Factor 1", "Factor 2", "Factor 3", "Factor 4",
                              "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(multiple_dei_score, file = "data/Comparison data/multiple_comparison_scores.rda")



# hawaiian
hawaiian_representation <- bind_rows(list(pct_hawaiian, hawaiian_df))
hawaiian_dei_score <- dei_scores(pct_hawaiian, hawaiian_df)

range_write(ss=google_sheet, data = hawaiian_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

hawaiian_representation$group <- "both sexes"
hawaiian_dei_score$group <- "both sexes"

# women
hawaiian_women_representation <- bind_rows(list(pct_hawaiian_women, hawaiian_df_women))
hawaiian_women_dei_score <- dei_scores(pct_hawaiian_women, hawaiian_df_women)

range_write(ss=google_sheet, data = hawaiian_women_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

hawaiian_women_representation$group <- "women"
hawaiian_women_dei_score$group <- "women"

# men
hawaiian_men_representation <- bind_rows(list(pct_hawaiian_men, hawaiian_df_men))
hawaiian_men_dei_score <- dei_scores(pct_hawaiian_men, hawaiian_df_men)

range_write(ss=google_sheet, data = hawaiian_men_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

hawaiian_men_representation$group <- "men"
hawaiian_men_dei_score$group <- "men"

hawaiian_representation <- bind_rows(hawaiian_representation, hawaiian_women_representation, hawaiian_men_representation)
hawaiian_representation$area <- c("Baseline Representation", "Current Representation", 
                                  "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                                  "Baseline Representation", "Current Representation", 
                                  "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                                  "Baseline Representation", "Current Representation", 
                                  "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(hawaiian_representation, file = "data/Comparison data/hawaiian_comparison.rda")

hawaiian_dei_score <- bind_rows(hawaiian_dei_score, hawaiian_women_dei_score, hawaiian_men_dei_score)
hawaiian_dei_score$group <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4",
                              "Factor 1", "Factor 2", "Factor 3", "Factor 4",
                              "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(hawaiian_dei_score, file = "data/Comparison data/hawaiian_comparison_scores.rda")

# Unknown
unknown_representation <- bind_rows(list(pct_unknown, unknown_df))
unknown_dei_score <- dei_scores(pct_unknown, unknown_df)

range_write(ss=google_sheet, data = unknown_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

unknown_representation$group <- "both sexes"
unknown_dei_score$group <- "both sexes"

# women
unknown_women_representation <- bind_rows(list(pct_unknown_women, unknown_df_women))
unknown_women_dei_score <- dei_scores(pct_unknown_women, unknown_df_women)

range_write(ss=google_sheet, data = unknown_women_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

unknown_women_representation$group <- "women"
unknown_women_dei_score$group <- "women"

# men
unknown_men_representation <- bind_rows(list(pct_unknown_men, unknown_df_men))
unknown_men_dei_score <- dei_scores(pct_unknown_men, unknown_df_men)

range_write(ss=google_sheet, data = unknown_men_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

unknown_men_representation$group <- "men"
unknown_men_dei_score$group <- "men"

unknown_representation <- bind_rows(unknown_representation, unknown_women_representation, unknown_men_representation)
unknown_representation$area <- c("Baseline Representation", "Current Representation", 
                                 "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                                 "Baseline Representation", "Current Representation", 
                                 "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                                 "Baseline Representation", "Current Representation", 
                                 "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(unknown_representation, file = "data/Comparison data/unknown_comparison.rda")

unknown_dei_score <- bind_rows(unknown_dei_score, unknown_women_dei_score, unknown_men_dei_score)
unknown_dei_score$group <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4",
                             "Factor 1", "Factor 2", "Factor 3", "Factor 4",
                             "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(unknown_dei_score, file = "data/Comparison data/unknown_comparison_scores.rda")

# White
white_representation <- bind_rows(list(pct_white, white_df))
white_dei_score <- dei_scores(pct_white, white_df)

range_write(ss=google_sheet, data = white_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

white_representation$group <- "both sexes"
white_dei_score$group <- "both sexes"

# women
white_women_representation <- bind_rows(list(pct_white_women, white_df_women))
white_women_dei_score <- dei_scores(pct_white_women, white_df_women)

range_write(ss=google_sheet, data = white_women_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

white_women_representation$group <- "women"
white_women_dei_score$group <- "women"

# men
white_men_representation <- bind_rows(list(pct_white_men, white_df_men))
white_men_dei_score <- dei_scores(pct_white_men, white_df_men)

range_write(ss=google_sheet, data = white_men_dei_score, sheet="DEI Health Index Scores", range="", col_names = FALSE, reformat = FALSE)

white_men_representation$group <- "men"
white_men_dei_score$group <- "men"

white_representation <- bind_rows(white_representation, white_women_representation, white_men_representation)
white_representation$area <- c("Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                               "Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4", 
                               "Baseline Representation", "Current Representation", 
                               "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(white_representation, file = "data/Comparison data/white_comparison.rda")

white_dei_score <- bind_rows(white_dei_score, white_women_dei_score, white_men_dei_score)
white_dei_score$group <- c("Factor 1", "Factor 2", "Factor 3", "Factor 4",
                           "Factor 1", "Factor 2", "Factor 3", "Factor 4",
                           "Factor 1", "Factor 2", "Factor 3", "Factor 4")
save(white_dei_score, file = "data/Comparison data/white_comparison_scores.rda")

################################################################################




# last update note
last_update = as_tibble(Sys.Date())
range_write(ss=google_sheet, data = last_update, sheet="DHI Dashboard All", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = last_update, sheet="Last Update", range="", col_names = FALSE, reformat = FALSE)
range_write(ss=google_sheet, data = last_update, sheet="Last Update", range="", col_names = FALSE, reformat = FALSE)




