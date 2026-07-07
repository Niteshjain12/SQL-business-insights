# SQL Business Interpretations

This document will contain the business insights for each SQL query.

## Query 1
Coming Soon

## Query 2

## Q2 – Monthly Signup Cohort Retention

### Business Objective

Measure how effectively newly acquired customers return and place orders in the months following their signup.

### Business Rules

- Cohorts are based on the customer's signup month.
- Customers who never place an order are still included in the cohort size.
- Cancelled orders are excluded from retention calculations.
- Future months that are not yet observable are displayed as NULL (censored) instead of 0%.

### Key Findings

- The March 2026 cohort has the highest observable retention because it has complete Month 1, Month 2, and Month 3 data.
- Retention decreases over time, which is a common pattern in customer lifecycle analysis.
- April and May cohorts have incomplete retention data due to the limited observation window.
- The June cohort has no observable retention yet because there are no later months available in the dataset.

### SQL Techniques Used

- CTEs
- LEFT JOIN
- COUNT(DISTINCT)
- Conditional aggregation using CASE
- Date arithmetic
- CROSS JOIN
- NULLIF

## Query 3
Coming Soon

## Query 4
Coming Soon

## Query 5
Coming Soon

## Query 6
Coming Soon

## Query 7
Coming Soon

## Query 8
Coming Soon

## Query 9
Coming Soon

## Query 10
Coming Soon
