# 🧾 Modified Jones Model – Financial Reporting Quality Analysis

This project implements the **Modified Jones Model** in R to assess the quality of financial reporting by estimating **discretionary accruals (DA)** and **absolute discretionary accruals (ADA)** for firms across different industries (banks).

---

## 🧠 Objective

To use the Modified Jones Model to:
- Estimate **non-discretionary accruals (NDA)** for each firm.
- Calculate **discretionary accruals (DA)** and their absolute values (ADA).
- Use ADA as a proxy for **financial reporting quality** — the lower the ADA, the higher the quality.

---

## 📊 Data Requirements

Input Excel File: `"Deposit Money Bank Financial Data"`  

### Required Columns (renamed for modeling convenience):
- `TA_scaled` → Total Accruals / Lagged Assets
- `inv_Asset` → Change in Inventory / Lagged Assets
- `rev_rec` → (Change in Revenue – Change in Receivables) / Lagged Assets
- `ppe_scaled` → PPE / Lagged Assets
- `Industry` → Industry or firm group identifier (e.g., banks)

---

## 🔄 Methodology

1. **Preprocessing**
   - Clean column names to remove illegal characters.
   - Rename columns to concise and model-friendly formats.

2. **Cross-sectional Regression**
   - Run separate regressions for each industry:
     ```
     TA_scaled ~ inv_Asset + rev_rec + ppe_scaled
     ```
   - Extract regression coefficients for each industry group.

3. **NDA Calculation**
   - Use the industry-level coefficients to calculate Non-Discretionary Accruals (NDA).

4. **DA & ADA Computation**
   - DA = TA_scaled – NDA
   - ADA = |DA| (absolute discretionary accruals)

5. **Final Output**
   - Clean dataframe with `Year`, `Industry`, `DA`, and `ADA` for reporting quality analysis.
   - Optionally save the full dataset as `Full_Data_With_DA_ADA.csv`.

---

## 💾 Output File

- `Full_Data_With_DA_ADA.csv`:  
  Contains the full dataset with DA and ADA values merged back with original records.

---

## 🛠️ Tools Used

- **Language**: R
- **Libraries**: `dplyr`, `broom`, `tidyr`, `readxl`

---

## 📈 Sample Metric

**Absolute Discretionary Accruals (ADA)**  
Used as a proxy for **earnings management**:
- **Lower ADA** → Higher financial reporting quality
- **Higher ADA** → Possible earnings manipulation

---

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---



## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://www.datascienceportfol.io/KehindeAromona)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/kehinde-gabriel-aromona-808578119/)
[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/kennycrown7)

