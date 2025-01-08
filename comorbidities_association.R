# Load necessary libraries
library(dplyr)
library(tidyr)
library(epitools)  # For odds ratio and confidence interval calculation

# Load your data
data <- read.csv("/Users/yogeshpurushotham/Desktop/nonexomics/IBD/untitled folder/rstudio-export/a1_fixed.csv")  # Update file path

# Split the comorbidities column by commas to separate individual comorbidities
data_expanded <- data %>%
  separate_rows(comorbidity, sep = ", ") %>%
  mutate(comorbidity = trimws(comorbidity))  # Trim whitespace

# Calculate total cases and controls
total_cases <- sum(data$group == "case")
total_controls <- sum(data$group == "control")

# Initialize a results data frame
results <- data.frame()

# Loop through each unique comorbidity to calculate statistics
unique_comorbidities <- unique(data_expanded$comorbidity)
for (comorbidity in unique_comorbidities) {
  # Contingency table
  case_count <- sum(data_expanded$group == "case" & data_expanded$comorbidity == comorbidity)
  control_count <- sum(data_expanded$group == "control" & data_expanded$comorbidity == comorbidity)
  other_case_count <- total_cases - case_count
  other_control_count <- total_controls - control_count
  contingency_table <- matrix(c(case_count, control_count, other_case_count, other_control_count), nrow = 2)
  
  # Calculate odds ratio, confidence intervals, and p-value
  or_result <- oddsratio.fisher(contingency_table)  # Fisher's exact test
  or <- or_result$measure[2, 1]  # Odds Ratio
  ci_lower <- or_result$measure[2, 2]  # Lower CI
  ci_upper <- or_result$measure[2, 3]  # Upper CI
  p_value <- or_result$p.value[2, 1]  # P-value
  
  # Append results to the data frame
  results <- rbind(results, data.frame(
    Comorbidity = comorbidity,
    Case_Count = case_count,
    Control_Count = control_count,
    Case_Percentage = (case_count / total_cases) * 100,
    Control_Percentage = (control_count / total_controls) * 100,
    Odds_Ratio = or,
    CI_Lower = ci_lower,
    CI_Upper = ci_upper,
    P_Value = p_value
  ))
}

# Display the first few rows of the results
print(head(results, 20))

# Save the results to a CSV file
write.csv(results, "/Users/yogeshpurushotham/Desktop/nonexomics/IBD/untitled folder/rstudio-export/comorbidity_odds_ratios_results.csv", row.names = FALSE)
