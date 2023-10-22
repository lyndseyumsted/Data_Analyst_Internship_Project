---
---
---

# Benchmarking workforce Diversity against Representation seen in the Talent Pool

## Table of Contents

-   [Introduction]
-   [Repository Organization]
-   [Data]
-   [Requirements]
-   [Installation]
-   [Use]
    -   [Data Retrieval]
    -   [DEI Automation]

## Introduction

This project was built for a Data Analyst Internship project completed this summer. All "company data" and "departments" in this repository are not reflective of any company's particular employee demographics and are instead psuedo data and departments to demonstrate how to benchmark a company's representation.

The output of this project is an automated pipeline which assesses a company's representation against external talent availability and DEI initiatives. This R-scripted project leverages available talent data in order to establish a framework for benchmarking and comparison. The automated pipeline contains a working script that programmatically updates and feeds talent demographics into a DEI Health Index Dashboard, which can be used to benchmark the company's overall representation, department-specific representation, and area-specific representation.

Below is an example of a dashboard comparing the representation of women in the talent pools of each area to the representation seen in a company. This kind of dynamic dashboard can be created with this tool and adding results to Google Sheets. Note: The company metrics and departments are dummy values and are not reflective of any company's demographics.

![](images/Screenshot%202023-08-03%20at%204.55.35%20PM.png)

This tool can programmatically assess and detect potential disparities among underrepresented groups. While this tool provides automated, real-time comparative metrics for such an assessment, there are also higher level impacts of this data integration. The automated dashboards help to provide an understanding of the intersectionality of a company's workforce. External talent pool benchmarking at a granular level assists in building and planning for future DE&I targets for improving representation at intersectional levels within a company.

The implementation of this pipeline developed my programming and data engineering skills by building out automated scripts which can retrieve, filter, extract, and integrate external data for assessment in a company's high level Diversity, Equity and Inclusion goals.

Talent is currently reflected by educational background which excludes skill set and job titles. Skill set and job title would be preferable additions to the talent indicator if demographic data is readily available with this data and is comparable to the internal company reporting.

## Repository Organization {data-link="Repository Organization"}

| Directory                            | Description                                                                                                         |
|--------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| **/data**                            | contains raw and processed data files from IPEDS dataset, example company demographics, and DEI Health Index scores |
| **/Final Pipeline**                  | contains the three folders *Data Retrieval* and *DEI Automation* for full pipeline                                  |
| **/Data Analysis and Visualization** | contains a prototype R markdown for visualizing disparities found in comparison between company and talent pool     |
| /**images**                          | contains image from README                                                                                          |

## Data

For United States data, this project uses the "number of awards by type of program, level of award (certificate or degree), first or second major and by race/ethnicity and gender" data set from the Integrated Post-secondary Education Data System (IPEDS), [a system of 12 interrelated survey components conducted annually that gathers data from every college, university, and technical and vocational institution that participates in the federal student financial aid programs. The data collections occur in fall, winter, and spring.](https://nces.ed.gov/ipeds/) This is sourced from the National Center for Education Statistics (NCES). The field of study (or type of program) is used to establish the talent indicator. This data source does not have an available Application Programming Interface (API), so data sets must be manually downloaded.

Global gender data is sourced from the Organization of Economic Cooperation and Development (OECD). Data on the breakdown of tertiary graduates of specific fields of study by gender was obtained from the "Education at a Glance" data source. [Education at a Glance is the authoritative source for data on the state of education around the world. It provides information on the structure, finances and performance of education systems across OECD countries and partner economies.](https://www.oecd.org/education/education-at-a-glance/) This data source will be ending at the end of the year 2023, so a new source with the same information should replace it. This data source does have an available API, and the data is retrieved this way.

For internal talent and demographic information, users need access to their company's demographics for ethnicity and gender as well as information on talent (educational background, skill set, job titles) to establish a proper framework for talent pools.

## Requirements

-   Access to Google sheets and Looker

-   Access to internal company demographic data

## Installation

-   Clone repository and create a copy to edit and add your data to.

## Use

For demonstration I will be using made up demographics from a made up company to show the pipeline. This hypothetical company has 5 sub-departments: Engineering, Marketing, Sales, Human Resources, and Legal which each have their own talent pools with some overlap in job roles and responsibilities. The hypothetical company also has offices in the global regions EMEA (Europe, Middle East, and Africa) and APAC(Asia-Pacific). The company as a whole and each department reports out their demographics for representation of gender (men and women), people of color (white and non-white), and distinct ethnic groups (American Indian or Alaska Native, Asian, Black or African American, Hispanic, Multiple Races, Native Hawaiian or Other Pacific Islander, Unknown, and White). The global regions only report out on gender. Using the demographics reported from these departments and regions, this pipeline will compare their representation to their relative talent pools for DE&I health assessment.

-   Within the *Final Pipeline* folder, three folders can be found: *Data Retrieval*, *DEI Automation*, and *EDA*. They are to be used in this order, starting with *Data Retrieval*.

### Data Retrieval

This folder contains the scripts to obtain both the IPEDS data and the OECD data. The first script to begin with is *IPEDS_FOI.R.*

-   *IPEDS_FOI.R* is the script needed to filter for relevant fields of study (CIPCODE) for your company or departments. The CIPCODE dictionary is already loaded in the data folder but can also be accessed from the [IPEDS website](https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?gotoReportId=7&fromIpeds=true) under "Complete Data Files". Look for C2021_A.

-   *IPEDS_data.R* retrieves the manually downloaded IPEDS' C20XX_A data sets as .csv files and filters them by sourcing the *IPEDS_FOI.R* script and renaming variables. The C2021_A data set and all other years are in this repository, but can also be downloaded from the same [IPEDS website](https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?gotoReportId=7&fromIpeds=true).

-   *OECD_API.R* is the script which pulls global gender demographics for fields of study in tertiary education using an API. The API query was copied from the [OECD website](https://stats.oecd.org/#). Go to *Education and Training* \> *Education at a Glance* \> *Students, access to education and participation* \> *Graduates by field*. From here, you can customize the indicators by clicking into *Customize.* To obtain the query filter click into *Export* \> *SDMX (XML)* \> copy the query under *SDMX DATA URL* right before "EDU_GRAD_FIELD/". This will be used to filter the data.

After this, your external data is retrieved and undergone initial filtering

### DEI Automation

This folder contains the scripts to reformat, extract, and compare the external talent representation with that seen internally. The first script to start with is *field_weights.R*.

-   *field_weights.R* uses the breakdown of job titles within the company and departments, as well as mapped educational background labels to created a data set with weights for balancing fields of study so the data is not skewed.

-   *data_wrangle.R* is the script which organizes talent and demographics data into each department and manipulates it to extract the relative representation for the gender and ethnic groups.

-   *DEI_Data_Automation.R* sources *data_wrangle.R* and is the script which effectively joins together the representation seen in the talent pools with the representation seen within the company, department, and region. The script also populates a DE&I Health Index Dashboard to visualize where the problem areas exist.
