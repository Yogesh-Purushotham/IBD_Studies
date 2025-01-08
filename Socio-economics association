# Socio-economics associations with case and control
import pandas as pd
import numpy as np
from scipy.stats import chi2_contingency, fisher_exact
import statsmodels.api as sm

# Load the dataset
df = pd.read_csv("a1_fixed.csv")

# Define case and control groups
case_group = df[df['group'] == 'case']
control_group = df[df['group'] == 'control']

# Loop through variables of interest to calculate statistics
results = []
variables = ['variable_1', 'variable_2', 'variable_n']  # Replace with actual column names

for var in variables:
    contingency_table = pd.crosstab(df[var], df['group'])
    
    # Perform Chi-Square or Fisher's Exact Test
    if contingency_table.shape[0] == 2:
        stat, p = fisher_exact(contingency_table.values)
    else:
        stat, p, _, _ = chi2_contingency(contingency_table.values)
    
    # Logistic Regression for ORs
    y = df['group'].apply(lambda x: 1 if x == 'case' else 0)
    x = pd.get_dummies(df[var], drop_first=True)
    x = sm.add_constant(x)
    model = sm.Logit(y, x).fit(disp=0)
    or_ci = np.exp(model.conf_int())
    or_vals = np.exp(model.params)

    # Append results
    results.append({
        "Variable": var,
        "Case (n, %)": f"{case_group[var].sum()} ({case_group[var].mean()*100:.2f}%)",
        "Control (n, %)": f"{control_group[var].sum()} ({control_group[var].mean()*100:.2f}%)",
        "Odds Ratio (95% CI)": f"{or_vals[1]:.2f} ({or_ci.iloc[1, 0]:.2f}-{or_ci.iloc[1, 1]:.2f})",
        "p-value": p
    })

# Create results DataFrame
results_df = pd.DataFrame(results)

# Save to CSV or Excel
results_df.to_csv("results_table.csv", index=False)
