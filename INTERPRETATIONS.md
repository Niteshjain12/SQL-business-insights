# SQL Business Interpretations

This document will contain the business insights for each SQL query.

## Query 1
Coming Soon

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

## Q3 – Funnel Conversion by Acquisition Channel

### Business Objective

Evaluate how effectively each acquisition channel moves users through the purchase funnel and identify where users drop off.

### Business Rules

- Funnel analysis includes only sessions from **19-Apr-2026 onwards**, because event tracking was introduced on that date.
- Acquisition channel is taken from the `session_channels` view (first-touch attribution).
- Sessions without an attributed channel are classified as **direct**.
- Funnel stages are calculated using distinct session counts to avoid counting multiple events within the same session.

### Key Findings

- Organic is the largest acquisition channel, followed by Paid.
- Across all major channels, approximately **40–41%** of sessions that viewed a product progressed to adding an item to the cart.
- Around **81%** of users who added items to the cart proceeded to checkout.
- Checkout completion is strong, with approximately **85–87%** of checkout sessions resulting in a purchase.
- Overall session-to-purchase conversion is approximately **28–29%** across most acquisition channels.
- Sessions before **19-Apr-2026** were excluded because event tracking had not yet been implemented. Missing events before that date should not be interpreted as zero conversion.

### SQL Techniques Used

- CTEs
- LEFT JOIN
- COALESCE
- COUNT(DISTINCT)
- FILTER clause
- NULLIF
- Aggregate functions

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
