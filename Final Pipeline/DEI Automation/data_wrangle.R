
# This script is designed to wrangle the IPEDS C20XX_A data into
# the format I use for EDA and google sheet writing. The data
# has been balanced to accurately mirror the company's
# workforce's educational background

# The output of this script is 14 tables of proportions
# ready to be read into a stored google sheet

# each table ending in counts_gender is a two way table
# where the proportion of men and women is reflected for 
# each race/ethnicity group and overall

# each table ending in counts_race is a two way table
# where the proportion of each race/ethnicity group 
# is reflected for men, women, and overall

# libraries
library(tidyverse)
library(censusapi)
library(dplyr)
library(ggplot2)
library(stringr)

# using filtered cipcodes
source("Final Pipeline/DEI Automation/field_weights.R")
source("Final Pipeline/Data Retrieval/OECD_API.R")


# loading in IPEDS data
load("data/IPEDS data/IPEDS_data.rda")


################################################################################

## balancing EMEA and APAC data

EMEA_fields <- left_join(EMEA_fields, field_weights, by = "field_of_degree")
EMEA_fields <- EMEA_fields %>% 
  mutate(counts = counts* Weight) %>% 
  group_by(sex) %>% 
  summarise(counts = sum(counts))


APAC_fields <- left_join(APAC_fields, field_weights, by = "field_of_degree")
APAC_fields <- APAC1_fields %>% 
  mutate(counts = counts * Weight) %>% 
  group_by(sex) %>% 
  summarise(counts = sum(counts))


# APAC and EMEA regions are not split by department

# finding sums for each sex for entire dataset

region_2_counts <- EMEA_fields[2]/colSums(EMEA_fields[2])
region_2_counts$sex <- EMEA_fields$sex
region_2_counts <- region_2_counts[,c(2,1)]

region_1_counts <- APAC_fields[2]/colSums(APAC_fields[2])
region_1_counts$sex <- APAC_fields$sex
region_1_counts <- region_1_counts[,c(2,1)]

save(region_2_counts, file = "data/Global data/region_2_counts.rda")
save(region_1_counts, file = "data/Global data/region_1_counts.rda")



################################################################################

## separating fields of interest and aggreagating counts and labeling general
## field of degree (Computer Science, Engineering, Advertisement, Communication,
## English, Mathematics, Human Resources, Economics, Finance, Data Science, 
## and Analytics)

# All 
all_fields <- IPEDS_data 
all_fields_agg <- all_fields[,-c(1,2,3)] %>% 
  group_by(year) %>% 
  summarise_all(sum) # summing across all universities
all_fields_agg$field_of_degree <- "All Fields"


# computer systems/software
computer_fields <- IPEDS_data %>% 
  filter(str_detect(field_of_degree, "^11.|^14.")) # CIPCODES starting with 11. are computer related
computer_fields_agg <- computer_fields[,-c(1,2,3)] %>% 
  group_by(year) %>% 
  summarise_all(sum) # summing across all universities
computer_fields_agg$field_of_degree <- "Computer Engineering"


# legal related fields
legal_fields <- IPEDS_data %>% 
  filter(str_detect(field_of_degree, "^22.")) 
legal_fields_agg <- legal_fields[,-c(1,2,3)] %>% 
  group_by(year) %>% 
  summarise_all(sum) # summing across all universities
legal_fields_agg$field_of_degree <- "Legal"


# business
business_fields <- IPEDS_data %>%  
  filter(str_detect(field_of_degree, "^09.|^10.|^23.|^27.")) 
business_fields_agg <- business_fields[,-c(1,2,3)] %>% 
  group_by(year) %>% 
  summarise_all(sum)# summing across all universities
business_fields_agg$field_of_degree <- "Business"



# hr
hr_fields <- IPEDS_data %>% 
  filter(str_detect(field_of_degree, "^52.")) 
hr_fields_agg <- hr_fields[,-c(1,2,3)] %>% 
  group_by(year) %>% 
  summarise_all(sum) # summing across all universities
hr_fields_agg$field_of_degree <- "Human Resources"


# psych/sociology
psych_fields <- IPEDS_data %>% 
  filter(str_detect(field_of_degree, "^42.|^45.")) 
psych_fields_agg <- psych_fields[,-c(1,2,3)] %>% 
  group_by(year) %>% 
  summarise_all(sum) # summing across all universities
psych_fields_agg$field_of_degree <- "Psych/Sociology"


# finance and accounting
finance_fields <- IPEDS_data %>% 
  filter(str_detect(field_of_degree, "^30.")) 
finance_fields_agg <- finance_fields[,-c(1,2,3)] %>% 
  group_by(year) %>% 
  summarise_all(sum) # summing across all universities
finance_fields_agg$field_of_degree <- "Finance and Accounting"




## Bringing it all together


# this data frame contains the counts for each intersection of ethnicity 
# and gender separated by each field of interest
edu_by_race_gender <- bind_rows(list(computer_fields_agg, finance_fields_agg, 
                                     psych_fields_agg, 
                                     hr_fields_agg, business_fields_agg,
                                     legal_fields_agg))


################################################################################


## separating above dataframe by sex 

# male
edu_by_race_m <- edu_by_race_gender[ , grep("_m", 
                                            colnames(edu_by_race_gender))] %>% # _m = male
  rename(total = total_m,
         hispanic = hispanic_m,
         white = white_m, # renaming original variables into ethnicity names
         black = black_m, # because this data will be labeled with a sex column
         ai_an = ai_an_m,
         asian = asian_m,
         hawaiian_pi = hawaiian_pi_m,
         multiple_race = multiple_race_m,
         unknown = unknown_m) 

# adding back field and creating sex column
edu_by_race_m$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_race_m$sex <- "male"
edu_by_race_m$year <- edu_by_race_gender$year # keeping year

# female
edu_by_race_f <- edu_by_race_gender[ , grep("_f", colnames(edu_by_race_gender))] %>% # _f = female
  rename(total = total_f,
         hispanic = hispanic_f,
         white = white_f,
         black = black_f,
         ai_an = ai_an_f,
         asian = asian_f,
         hawaiian_pi = hawaiian_pi_f,
         multiple_race = multiple_race_f,
         unknown = unknown_f)

# adding back field and creating sex column
edu_by_race_f$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_race_f$sex <- "female"
edu_by_race_f$year <- edu_by_race_gender$year

# combining the sexes so that this is a dataframe of counts for each 
# ethnicity by sex and field of interest
edu_by_race <- bind_rows(list(edu_by_race_m, edu_by_race_f))


edu_by_race <- left_join(edu_by_race, field_weights, by = "field_of_degree")
edu_by_race <- edu_by_race %>% 
  mutate(total = total * Weight) %>% 
  mutate(ai_an = ai_an * Weight) %>% 
  mutate(asian = asian * Weight) %>% 
  mutate(black = black * Weight) %>% 
  mutate(hispanic = hispanic * Weight) %>% 
  mutate(hawaiian_pi = hawaiian_pi * Weight) %>% 
  mutate(white = white * Weight) %>% 
  mutate(multiple_race = multiple_race * Weight) %>% 
  mutate(unknown = unknown * Weight)
################################################################################


## separating by race


# Hispanic
edu_by_sex_hispanic <- edu_by_race_gender[ , grep("hispanic", 
                                                  colnames(edu_by_race_gender))] %>% 
  rename(male = hispanic_m, # renaming original variables into sex names
         female = hispanic_f) # because this data will be labeled with a race column

# adding back field and creating race column
edu_by_sex_hispanic$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_sex_hispanic$race<- "Hispanic"
edu_by_sex_hispanic$year <- edu_by_race_gender$year # keeping year

# White
edu_by_sex_white <- edu_by_race_gender[ , grep("white", colnames(edu_by_race_gender))] %>% 
  rename(male = white_m,
         female = white_f)

# adding back field and creating race column
edu_by_sex_white$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_sex_white$race<- "White"
edu_by_sex_white$year <- edu_by_race_gender$year


# Black
edu_by_sex_black <- edu_by_race_gender[ , grep("black", colnames(edu_by_race_gender))] %>% 
  rename(male = black_m,
         female = black_f)

# adding back field and creating race column
edu_by_sex_black$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_sex_black$race<- "Black"
edu_by_sex_black$year <- edu_by_race_gender$year

# American Indian/Alaska Native
edu_by_sex_ai_an <- edu_by_race_gender[ , grep("ai_an", colnames(edu_by_race_gender))] %>% 
  rename(male = ai_an_m,
         female = ai_an_f)

# adding back field and creating race column
edu_by_sex_ai_an$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_sex_ai_an$race<- "American Indian/Alaska Native"
edu_by_sex_ai_an$year <- edu_by_race_gender$year

# Asian
edu_by_sex_asian <- edu_by_race_gender[ , grep("asian", colnames(edu_by_race_gender))] %>% 
  rename(male = asian_m,
         female = asian_f)

# adding back field and creating race column
edu_by_sex_asian$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_sex_asian$race<- "Asian"
edu_by_sex_asian$year <- edu_by_race_gender$year

# Hawaiian/Other Pacific Islander
edu_by_sex_hawaiian_pi <- edu_by_race_gender[ , grep("hawaiian_pi", colnames(edu_by_race_gender))] %>% 
  rename(male = hawaiian_pi_m,
         female = hawaiian_pi_f)

# adding back field and creating race column
edu_by_sex_hawaiian_pi$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_sex_hawaiian_pi$race<- "Native Hawaiian/Other Pacific Islander"
edu_by_sex_hawaiian_pi$year <- edu_by_race_gender$year

# Multiple Races
edu_by_sex_multiple <- edu_by_race_gender[ , grep("multiple", colnames(edu_by_race_gender))] %>% 
  rename(male = multiple_race_m,
         female = multiple_race_f)

# adding back field and creating race column
edu_by_sex_multiple$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_sex_multiple$race<- "Multiple Races"
edu_by_sex_multiple$year <- edu_by_race_gender$year

# Unknown
edu_by_sex_unknown <- edu_by_race_gender[ , grep("unknown", colnames(edu_by_race_gender))] %>% 
  rename(male = unknown_m,
         female = unknown_f)

# adding back field and creating race column
edu_by_sex_unknown$field_of_degree <- edu_by_race_gender$field_of_degree
edu_by_sex_unknown$race<- "Unknown"
edu_by_sex_unknown$year <- edu_by_race_gender$year


## Bringing it all Together
# creating dataframe of counts of each sex by field of interest and ethnicity
edu_by_gender <- bind_rows(list(edu_by_sex_hispanic, edu_by_sex_white, 
                                edu_by_sex_black, edu_by_sex_ai_an, 
                                edu_by_sex_asian, edu_by_sex_hawaiian_pi,
                                edu_by_sex_multiple, edu_by_sex_unknown))
edu_by_gender <- left_join(edu_by_gender, field_weights, by = "field_of_degree")
edu_by_gender <- edu_by_gender %>% 
  mutate(male = male * Weight) %>% 
  mutate(female = female * Weight)

################################################################################


# attribute data set with counts using gather
counts_data <- edu_by_gender %>% 
  gather(key = "sex", value = "counts", male, female)



################################################################################

# deciding what fields to put into each department (can always change)

# Engineering: Computer Engineering
# Marketing: 




counts_data <- counts_data[-5]
save(counts_data, file = "data/IPEDS data/counts_data.rda")


################################################################################




################################################################################

# these are the same as edu_by_gender and edu_by_race respectively, 
# just getting rid of 
spread_data_gender <- edu_by_gender[-c(3,5,7)] %>% 
  group_by(Department, race) %>% 
  summarise_at(c(1:2), sum)
spread_data_race <- edu_by_race[-c(1,10,12,14)] %>% 
  group_by(Department, sex) %>% 
  rename(American_Indian_Alaska_Native = ai_an,
         Asian = asian,
         Black = black,
         Hispanic = hispanic,
         Native_Hawaiian_Other_Pacific_Islander = hawaiian_pi,
         Multiple_Races = multiple_race,
         Unknown = unknown,
         White = white) %>% 
  summarise_at(c(1:8), sum)

################################################################################

## getting breakdown of race/ethnicity and sex for each Department

# all departments
all_departments_counts <- spread_data_gender %>% 
  filter(Department == "Overall") %>%
  group_by(race) %>% 
  summarise_at(c("male", "female"), sum)
all_departments_counts <- rbind(all_departments_counts, data.frame(race='Overall', t(colSums(all_departments_counts[, -1]))))

all_departments_counts2 <- spread_data_race %>%
  filter(Department == "Overall") %>% 
  group_by(sex) %>% 
  summarise_at(c("American_Indian_Alaska_Native", 
            "Asian", "Black", "Native_Hawaiian_Other_Pacific_Islander",
            "Hispanic", "Multiple_Races", "Unknown", "White"), sum)
all_departments_counts2 <- rbind(all_departments_counts2, data.frame(sex='Overall', t(colSums(all_departments_counts2[, -1]))))

# two way table for gender breakdown for each ethnic group and overall
# overall metrics to use in women Dashboard
all_departments_counts_gender <- all_departments_counts[2:3]/rowSums(all_departments_counts[2:3]) 
all_departments_counts_gender$race <- all_departments_counts$race
all_departments_counts_gender <- all_departments_counts_gender[,c(3,1,2)]

# two way table for ethnicity breakdown for each gender group and overall
# overall metrics to use in POC and Ethnicity Dashboards
all_departments_counts_race <- all_departments_counts2[2:9]/rowSums(all_departments_counts2[2:9]) 
all_departments_counts_race$sex <- all_departments_counts2$sex
all_departments_counts_race <- all_departments_counts_race[,c(9,1,2,3,4,5,6,7,8)]

save(all_departments_counts_gender, file = "data/IPEDS data/all_departments_counts_gender.rda")
save(all_departments_counts_race, file = "data/IPEDS data/all_departments_counts_race.rda")

# separate departments

# Engineering
Engineering_counts <- spread_data_gender %>% 
  filter(Department == "Engineering") %>%
  group_by(race) %>% 
  summarise_at(c("male", "female"), sum)
Engineering_counts <- rbind(Engineering_counts, data.frame(race='Overall', t(colSums(Engineering_counts[, -1]))))

Engineering_counts2 <- spread_data_race %>%
  filter(Department == "Engineering") %>% 
  group_by(sex) %>% 
  summarise_at(c("American_Indian_Alaska_Native", 
                 "Asian", "Black", "Native_Hawaiian_Other_Pacific_Islander",
                 "Hispanic", "Multiple_Races", "Unknown", "White"), sum)
Engineering_counts2 <- rbind(Engineering_counts2, data.frame(sex='Overall', t(colSums(Engineering_counts2[, -1]))))

# two way table for gender breakdown for each ethnic group and overall
# overall metrics to use in women Dashboard
Engineering_counts_gender <- Engineering_counts[2:3]/rowSums(Engineering_counts[2:3]) 
Engineering_counts_gender$race <- Engineering_counts$race
Engineering_counts_gender <- Engineering_counts_gender[,c(3,1,2)]

# two way table for ethnicity breakdown for each gender group and overall
# overall metrics to use in POC and Ethnicity Dashboards
Engineering_counts_race <- Engineering_counts2[2:9]/rowSums(Engineering_counts2[2:9]) 
Engineering_counts_race$sex <- Engineering_counts2$sex
Engineering_counts_race <- Engineering_counts_race[,c(9,1,2,3,4,5,6,7,8)]

save(Engineering_counts_gender, file = "data/IPEDS data/Engineering_counts_gender.rda")
save(Engineering_counts_race, file = "data/IPEDS data/Engineering_counts_race.rda")


# Marketing
Marketing_counts <- spread_data_gender %>% 
  filter(Department == "Marketing") %>%
  group_by(race) %>% 
  summarise_at(c("male", "female"), sum)
Marketing_counts <- rbind(Marketing_counts, data.frame(race='Overall', t(colSums(Marketing_counts[, -1]))))

Marketing_counts2 <- spread_data_race %>%
  filter(Department == "Marketing") %>% 
  group_by(sex) %>% 
  summarise_at(c("American_Indian_Alaska_Native", 
                 "Asian", "Black", "Native_Hawaiian_Other_Pacific_Islander",
                 "Hispanic", "Multiple_Races", "Unknown", "White"), sum)
Marketing_counts2 <- rbind(Marketing_counts2, data.frame(sex='Overall', t(colSums(Marketing_counts2[, -1]))))

# two way table for gender breakdown for each ethnic group and overall
# overall metrics to use in women Dashboard
Marketing_counts_gender <- Marketing_counts[2:3]/rowSums(Marketing_counts[2:3]) 
Marketing_counts_gender$race <- Marketing_counts$race
Marketing_counts_gender <- Marketing_counts_gender[,c(3,1,2)]

# two way table for ethnicity breakdown for each gender group and overall
# overall metrics to use in POC and Ethnicity Dashboards
Marketing_counts_race <- Marketing_counts2[2:9]/rowSums(Marketing_counts2[2:9]) 
Marketing_counts_race$sex <- Marketing_counts2$sex
Marketing_counts_race <- Marketing_counts_race[,c(9,1,2,3,4,5,6,7,8)]

save(Marketing_counts_gender, file = "data/IPEDS data/Marketing_counts_gender.rda")
save(Marketing_counts_race, file = "data/IPEDS data/Marketing_counts_race.rda")


# Sales
Sales_counts <- spread_data_gender %>% 
  filter(Department == "Sales") %>%
  group_by(race) %>% 
  summarise_at(c("male", "female"), sum)
Sales_counts <- rbind(Sales_counts, data.frame(race='Overall', t(colSums(Sales_counts[, -1]))))

Sales_counts2 <- spread_data_race %>%
  filter(Department == "Sales") %>% 
  group_by(sex) %>% 
  summarise_at(c("American_Indian_Alaska_Native", 
                 "Asian", "Black", "Native_Hawaiian_Other_Pacific_Islander",
                 "Hispanic", "Multiple_Races", "Unknown", "White"), sum)
Sales_counts2 <- rbind(Sales_counts2, data.frame(sex='Overall', t(colSums(Sales_counts2[, -1]))))

# two way table for gender breakdown for each ethnic group and overall
# overall metrics to use in women Dashboard
Sales_counts_gender <- Sales_counts[2:3]/rowSums(Sales_counts[2:3]) 
Sales_counts_gender$race <- Sales_counts$race
Sales_counts_gender <- Sales_counts_gender[,c(3,1,2)]

# two way table for ethnicity breakdown for each gender group and overall
# overall metrics to use in POC and Ethnicity Dashboards
Sales_counts_race <- Sales_counts2[2:9]/rowSums(Sales_counts2[2:9]) 
Sales_counts_race$sex <- Sales_counts2$sex
Sales_counts_race <- Sales_counts_race[,c(9,1,2,3,4,5,6,7,8)]

save(Sales_counts_gender, file = "data/IPEDS data/Sales_counts_gender.rda")
save(Sales_counts_race, file = "data/IPEDS data/Sales_counts_race.rda")

# Human Resources
HR_counts <- spread_data_gender %>% 
  filter(Department == "Human Resources") %>%
  group_by(race) %>% 
  summarise_at(c("male", "female"), sum)
HR_counts <- rbind(HR_counts, data.frame(race='Overall', t(colSums(HR_counts[, -1]))))

HR_counts2 <- spread_data_race %>%
  filter(Department == "Human Resources") %>% 
  group_by(sex) %>% 
  summarise_at(c("American_Indian_Alaska_Native", 
                 "Asian", "Black", "Native_Hawaiian_Other_Pacific_Islander",
                 "Hispanic", "Multiple_Races", "Unknown", "White"), sum)
HR_counts2 <- rbind(HR_counts2, data.frame(sex='Overall', t(colSums(HR_counts2[, -1]))))

# two way table for gender breakdown for each ethnic group and overall
# overall metrics to use in women Dashboard
HR_counts_gender <- HR_counts[2:3]/rowSums(HR_counts[2:3]) 
HR_counts_gender$race <- HR_counts$race
HR_counts_gender <- HR_counts_gender[,c(3,1,2)]

# two way table for ethnicity breakdown for each gender group and overall
# overall metrics to use in POC and Ethnicity Dashboards
HR_counts_race <- HR_counts2[2:9]/rowSums(HR_counts2[2:9]) 
HR_counts_race$sex <- HR_counts2$sex
HR_counts_race <- HR_counts_race[,c(9,1,2,3,4,5,6,7,8)]

save(HR_counts_gender, file = "data/IPEDS data/HR_counts_gender.rda")
save(HR_counts_race, file = "data/IPEDS data/HR_counts_race.rda")



# G&A
Legal_counts <- spread_data_gender %>% 
  filter(Department == "Legal") %>%
  group_by(race) %>% 
  summarise_at(c("male", "female"), sum)
Legal_counts <- rbind(Legal_counts, data.frame(race='Overall', t(colSums(Legal_counts[, -1]))))

Legal_counts2 <- spread_data_race %>%
  filter(Department == "Legal") %>% 
  group_by(sex) %>% 
  summarise_at(c("American_Indian_Alaska_Native", 
                 "Asian", "Black", "Native_Hawaiian_Other_Pacific_Islander",
                 "Hispanic", "Multiple_Races", "Unknown", "White"), sum)
Legal_counts2 <- rbind(Legal_counts2, data.frame(sex='Overall', t(colSums(Legal_counts2[, -1]))))

# two way table for gender breakdown for each ethnic group and overall
# overall metrics to use in women Dashboard
Legal_counts_gender <- Legal_counts[2:3]/rowSums(Legal_counts[2:3]) 
Legal_counts_gender$race <- Legal_counts$race
Legal_counts_gender <- Legal_counts_gender[,c(3,1,2)]

# two way table for ethnicity breakdown for each gender group and overall
# overall metrics to use in POC and Ethnicity Dashboards
Legal_counts_race <- Legal_counts2[2:9]/rowSums(Legal_counts2[2:9]) 
Legal_counts_race$sex <- Legal_counts2$sex
Legal_counts_race <- Legal_counts_race[,c(9,1,2,3,4,5,6,7,8)]

save(Legal_counts_gender, file = "data/IPEDS data/Legal_counts_gender.rda")
save(Legal_counts_race, file = "data/IPEDS data/Legal_counts_race.rda")

################################################################################







