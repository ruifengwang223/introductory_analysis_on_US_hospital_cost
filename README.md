# Executive Summary of Introductory Analysis on US Hospital Cost

## Project Overview

The project's objective is to analyze the Hospital Cost Datasets (2017–2022) from Centers for Medicare & Medicaid Services (CMS) to uncover cost trends and regional variations, also indicate the relationship between total cost and hospital types of control. The author used SAS for data preprocessing and R for data analysis.

I also imported the census data to calculate the total per capita cost.

## Data Preprocessing

The raw dataset is in the form of CSV file, I uploaded all datasets into SAS Studio, and used macro program to import CSVs into SAS console. Then standardized data format, renamed the variables to comply the column name regulations in SAS and R.

## Exploratory Analysis & Visualizations

**Trend of Per-Capita Cost:** I analyzed the cost trend among states, and add variables to mark the regions and divisions based on states. I outputted the trend plots of total per capita cost based on states, regions, and divisions.

**Type of Control Share:**

I grouped 13 types of control into 3 big groups: Voluntary, Proprietary, and Governmental. The per-capita cost in Voluntary and Governmental are significantly lower than the Proprietary.

## Key Insights

- The total cost increased over the years.
- The New England area had the highest per-capita cost
- The type of control share significantly impacted on the total cost.

## Limitations and Further Work

No reasonable variable is found as target variable in this case. And all attempts of model prediction performed bad.

Due to the limitation of accounting knowledge, I can not deep analysis the components of cost in this time, I can only analyze the trend and pattern cross different factors instead. In the further work, I am going to research more on hospital accounting, to uncover the insights about hospital cost.
