# run_project.R

# Load the environment
source("user_profile.R")

# Source scripts 
source("R/01_clean_data.R")

# Knit the report (PDF, HTML, or Word)
rmarkdown::render(here::here("reports", "report.Rmd"),
                  output_format = "html_document", 
                  output_file = here::here("output", "final_report.html"))
