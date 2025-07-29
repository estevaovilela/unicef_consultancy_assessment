# run_project.R

# Clean all the data and produces two .RData treated files

# Library -----------------------------------------------------------------

library(readxl)
library(tidyverse)

# Reading files -----------------------------------------------------------

# Maternal-and-Newborn-Health-Coverage-Database-November-2024
# Antenatal care coverage: at least four visits
# Percentage of women (age 15–49)  attended at least four times during pregnancy by any provider. 
MNCH_ANC4 <- readxl::read_excel("data/raw/Maternal-and-Newborn-Health-Coverage-Database-November-2024.xlsx", sheet = "ANC4", skip = 4)

# Maternal-and-Newborn-Health-Coverage-Database-November-2024
# Delivery assisted by a skilled birth attendant
# Percentage of births delivered by a skilled health personnel (typically doctor, midwife and or nurse)
MNCH_SAB <- readxl::read_excel("data/raw/Maternal-and-Newborn-Health-Coverage-Database-November-2024.xlsx", sheet = "SAB", skip = 4)

# World Population Prospects 2022
population_projections <- readxl::read_excel("data/raw/WPP2022_GEN_F01_DEMOGRAPHIC_INDICATORS_COMPACT_REV1.xlsx", skip = 16, col_types = "text", sheet = "Projections")

# Under 5 classification
country_classification <- readxl::read_excel("data/raw/On-track and off-track countries.xlsx")

# Cleaning, wrangling and merging ------------------------------------------

MNCH_ANC4_per_country <- MNCH_ANC4 %>% 
  filter(between(Year, 2018, 2022)) %>% 
  filter(!is.na(National)) %>% 
  select(ISO, `Countries and areas`, Year, `Long Source`, National) %>% 
  setNames(c("ISO3", "country", "year", "source", "ANC4_value")) %>% 
  arrange(ISO3, desc(year)) %>% 
  group_by(ISO3) %>% 
  slice(1L) %>% # filtering most recent estimate
  ungroup()

MNCH_SAB_per_country <- MNCH_SAB %>% 
  filter(between(Year, 2018, 2022)) %>% 
  filter(!is.na(National)) %>% 
  select(ISO, `Countries and areas`, Year, `Long Source`, National) %>% 
  setNames(c("ISO3", "country", "year", "source", "SAB_value")) %>% 
  arrange(ISO3, desc(year)) %>% 
  group_by(ISO3) %>% 
  slice(1L) %>% # filtering most recent estimate
  ungroup()

births_per_country <- population_projections %>% 
  filter(Type == "Country/Area", Year == 2022) %>% 
  select(`ISO3 Alpha-code`,
         `Births (thousands)`) %>% 
  setNames(c("ISO3", "births"))  %>% 
  mutate(ISO3 = ifelse(ISO3 == "XKX", "RKS", ISO3)) %>% # correcting ISO code for Kosovo
  mutate(births = as.double(births))

under_5_classification <- country_classification %>% 
  mutate(classification = ifelse(Status.U5MR == "Acceleration Needed", "off track", "on track"))

# Combining data sets ------------------------------------------------------

MNCH_SAB_with_births <- MNCH_SAB_per_country %>% 
  left_join(under_5_classification,
            by = c("ISO3" = "ISO3Code")) %>%
  filter(!is.na(classification)) %>% 
  left_join(births_per_country,
            by = c("ISO3"))

MNCH_ANC4_with_births <- MNCH_ANC4_per_country %>% 
  left_join(under_5_classification,
            by = c("ISO3" = "ISO3Code")) %>%
  filter(!is.na(classification)) %>% 
  left_join(births_per_country,
            by = c("ISO3")) 

# Output -------------------------------------------------------------------

save(MNCH_SAB_with_births, file = "data/treated/MNCH_SAB_with_births.RData")

save(MNCH_ANC4_with_births, file = "data/treated/MNCH_ANC4_with_births.RData")

rm(list = ls())
