#Modified Jones Model Financial Reporting Quality
#Modified Jones Model
library(dplyr)
library(broom)
library(tidyr)

rm(list=ls())

#load data
data <- read_excel("New Data Collection.xlsx", sheet = "Worked On")

colnames(data) <- make.names(colnames(data)) #remove illegal character
head(data)

print(colnames(data))

#rename heading for convenience
data <- data %>%
  rename(
    Industry = Bank,
    TA_scaled = TA.Lagged.Assets,
    inv_Asset = X1.Lagged.Assets,
    rev_rec = X.ΔRev..ΔRec..Lagged.Assets,
    ppe_scaled = PPE.Lagged.Assets
  )

# Run regression for each industry (bank)
industry_coeffs <- data %>%
  group_by(Industry) %>%
  do({
    model <- lm(TA_scaled ~ inv_Asset + rev_rec + ppe_scaled, data = .)
    tidy(model)
  }) %>%
  ungroup()

# Pivot to wide format for merging
alpha_wide <- industry_coeffs %>%
  select(Industry, term, estimate) %>%
  pivot_wider(names_from = term, values_from = estimate)

# Merge industry alpha values back to the main data
data <- left_join(data, alpha_wide, by = "Industry")

# Compute NDA using coefficients
data <- data %>%
  mutate(
    NDA = `(Intercept)` + inv_Asset.x * inv_Asset.x + rev_rec.x * rev_rec.x + ppe_scaled.x * ppe_scaled.x
  )

#Computing Discretionary Accruals & Financial Quality
data <- data %>%
  mutate(
    DA = TA_scaled - NDA,
    ADA = abs(DA)  # This is your financial report quality measure
  )

# Create a clean data frame with just the values you need
financial_quality_df <- data %>%
  select(Year, Industry, DA, ADA)

# Merge back with original data
data_combined <- left_join(data, financial_quality_df, by = c("Year", "Industry"))

# Save the combined dataset
write.csv(data_combined, "Full_Data_With_DA_ADA.csv", row.names = FALSE)