# Consultancy with the D&A Education Team

This repository contains the tasks for the **UNICEF Data and Analytics technical evaluation** for education.

------------------------------------------------------------------------

## Positions applied

-   Administrative Data Analyst – Req. #581696

------------------------------------------------------------------------

## Project Organization

```         
├── LICENSE
├── README.md                  <- The top-level README for developers using this project (also known as this file!)
├── run_project.R              <- R script for running all analysis
├── user_profile.R             <- Restoration of the R package environment
├── data
│   ├── treated                <- The cleaned and treated data for analysis
│   └── raw                    <- The original, immutable data dump
├── R                          <- R scripts for cleaning and treating data
├── reports                    <- RMarkdown scripts
├── output                     <- Final Report
├── renv                       <- automatically created by the {renv} package in an R project to track and isolate the R package environment.
```

## Description of each file

|  |  |
|-------------------------------|-----------------------------------------|
| **README.md** | This file |
| **Consultancy-Assessment.Rproj** | RStudio Project file |
| **run_project.R** | R script for running all analysis |
| **user_profile.R** | Restoration of the R package environment |
| **data/raw/Maternal-and-Newborn-Health-Coverage-Database-November-2024.xlsx** | "Maternal and Newborn Health Coverage Database" excel file with 'Antenatal care coverage: at least four visits' and 'Delivery assisted by a skilled birth attendant' sheets |
| **data/raw/On-track and off-track countries.xlsx** | Under-five mortality classification |
| **data/raw/WPP2022_GEN_F01_DEMOGRAPHIC_INDICATORS_COMPACT_REV1.xlsx** | Population Data: UN World Population Prospects, 2022 |
| **data/treated/MNCH_ANC4_with_births.xlsx** | Antenatal care (ANC4) most recent estimate per country |
| **data/treated/MNCH_SAB_with_births.xlsx** | Skilled birth attendance (SBA) most recent estimate per country |
| **R/01_clean_data** | Loads the raw data, clean and merge all information and produces the .RData files stored in data/treated folder |
| **reports/report.Rmd** | Loads the treated data, computes weighted coverages and ggplot variables and produces the .html final report stored in output/ folder |
| **output/report.html** | Final report |
| **renv** | automatically created by the {renv} package in an R project to track and isolate the R package environment. |

## How to run

Clone this repository to your local computer. Use RStudio.

1.  Open `unicef_consultancy_assessment.Rproj` into RStudio.
2.  Run `run_project.R`. If needed, all packages necessary to run the codes will be installed in the renv/library folder
3.  Final report will be saved to `output/final_report.html`
