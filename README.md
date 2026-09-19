# E-Commerce Executive Sales & Logistics Performance Dashboard

An end-to-end Power BI business intelligence solution designed to monitor macro revenue trajectory, customer RFM cohorts, and fulfillment SLA bottlenecks across multi-year transactional operations.

---

## 📊 Dashboard Preview

![Dashboard Preview](dashboard_preview.png)

---

## 🎯 Project Overview

Modern e-commerce operations often suffer from siloed reporting where top-line financial performance is decoupled from fulfillment bottlenecks and customer retention dynamics. 

This project consolidates multi-dimensional sales, customer, and shipping data into an executive-level single-page interface to provide leadership with immediate visibility into:
- Revenue growth stability and month-over-month (MoM) trajectory.
- Value distribution across customer retention cohorts.
- Regional shipping bottlenecks impacting customer experience.

---

## 📈 Key Performance Indicators (KPIs)

- Total Revenue (GMV): $15.42M
- Delivered Orders: 96K
- Average Customer Spend (AOV): $165.20

---

## 🧩 Visual Breakdown & Analytical Structure

### 1. Header Banner & Dynamic Time Slicer
- Unified card-style banner providing dashboard context and executive naming hierarchy.
- Integrated continuous timeline slicer (`order_month`) allowing dynamic date-range cross-filtering across all visuals.

### 2. Monthly GMV & MoM Growth % (Combo Chart)
- Primary Axis: Monthly gross merchandise value (GMV) tracking historical sales volume.
- Secondary Axis: Month-over-month (MoM) growth percentage tracking sales acceleration and post-holiday corrections.
- Data Engineering Treatment: Handled historical launch outliers through targeted date boundaries to preserve realistic scaling across active trading periods.

### 3. Customer Breakdown by RFM Segment (Donut Chart)
- Segments total user base into four core behavioral cohorts:
  - Champions / VIP
  - Potential Loyalists
  - At Risk / High Value
  - Lost / Churned
- Displays slice proportions and distinct customer counts to guide retention and re-engagement marketing strategies.

### 4. Top 10 States by Late Delivery Rate % (Horizontal Bar Chart)
- Isolates logistics fulfillment risks by ranking regional delivery failure rates.
- Highlights high-risk geographic areas (e.g., states with >20% late delivery rates) to support carrier SLA audits and fulfillment route optimization[cite: 12].
- Includes total delivered order volume in tooltips for operational context.

---

## 🛠️ Technical Stack & Architecture

- Business Intelligence: Microsoft Power BI Desktop
- Data Modeling & Measures: DAX (Time Intelligence, Aggregations, Distinct Counts)
- Data Transformation: SQL / Power Query (Data cleaning, outlier handling, type conversions)
- UI/UX Design: Modular white card-container layout, 8px rounded corners, custom color palette (`#1E293B`, `#0F172A`), balanced typography hierarchy.

---

## 📂 Repository Structure

```text
├── data/
│   ├── monthly_sales_growth.csv
│   ├── rfm_customer_segments.csv
│   └── delivery_sla_by_state.csv
├── Ecommerce_Executive_Dashboard.pbix
├── dashboard_preview.png
└── README.md
