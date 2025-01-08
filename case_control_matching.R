## Code to conduxt case control matching with 1:4 ratio and matching them based them on age, sex and race

# Load necessary libraries
library(dplyr)
library(lubridate)

# Load datasets
case_data <- read.csv("/Users/yogeshpurushotham/Desktop/nonexomics/IBD/untitled folder/rstudio-export/combined_ibd_case.csv")
control_data <- read.csv("/Users/yogeshpurushotham/Desktop/nonexomics/IBD/untitled folder/rstudio-export/combined_control_group.csv")

# Standardize column names
colnames(case_data) <- tolower(colnames(case_data))
colnames(control_data) <- tolower(colnames(control_data))

# Remove the 'drug' column from the case dataset
case_data <- case_data %>%
  select(-drug)

# Convert date_of_birth to Date format and calculate age
case_data <- case_data %>%
  mutate(date_of_birth = ymd_hms(date_of_birth),  # Parse date with time
         age = floor(interval(date_of_birth, Sys.Date()) / years(1))) %>%
  select(-date_of_birth)

control_data <- control_data %>%
  mutate(date_of_birth = ymd_hms(date_of_birth),  # Parse date with time
         age = floor(interval(date_of_birth, Sys.Date()) / years(1))) %>%
  select(-date_of_birth)

# Add a 'group' column to distinguish cases and controls
case_data <- case_data %>%
  mutate(group = "case")

control_data <- control_data %>%
  mutate(group = "control")

# Perform 1:4 matching
set.seed(123)  # Ensure reproducibility
matched_controls <- control_data %>%
  group_by(gender, race) %>%  # Match on gender and race
  sample_n(size = min(4 * nrow(case_data), n()), replace = FALSE) %>%
  ungroup()

# Check if matched controls exceed the 1:4 ratio and trim
if (nrow(matched_controls) > 4 * nrow(case_data)) {
  matched_controls <- matched_controls %>% sample_n(4 * nrow(case_data))
}

# Combine cases and matched controls
combined_data <- bind_rows(case_data, matched_controls)

# Display the structure of the combined dataset
print("Summary of Combined Data")
print(summary(combined_data))

# Additional checks
num_cases <- nrow(filter(combined_data, group == "case"))
num_controls <- nrow(filter(combined_data, group == "control"))

print(paste("Number of cases:", num_cases))
print(paste("Number of controls:", num_controls))
print(paste("Case:Control ratio:", round(num_controls / num_cases, 2)))

# Save the combined dataset for further analysis
write.csv(combined_data, "/Users/yogeshpurushotham/Desktop/nonexomics/IBD/untitled folder/rstudio-export/a1_fixed.csv", row.names = FALSE)
