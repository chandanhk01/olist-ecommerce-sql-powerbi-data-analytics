# 🛒 Olist E-Commerce Data Analytics | SQL & Power BI

## 📌 Project Overview

This project explores e-commerce performance using SQL and Microsoft Power BI. The goal is to analyze sales, products, sellers, orders, delivery performance, customer behaviour, and payment patterns through SQL queries and an interactive, four-page dashboard.

The dashboard transforms raw e-commerce data into meaningful business insights to support data-driven decision-making.

## 🎯 Project Objectives

- Analyze overall sales and order performance.
- Identify top-performing products and sellers.
- Compare actual delivery times with estimated delivery times.
- Explore customer distribution across Brazilian states.
- Analyze payment methods, installments, and review scores.
- Examine order statuses and cancellations.
- Build an interactive dashboard for exploring business performance.

## 🗄️ Dataset & SQL Analysis

The project uses the Olist Brazilian E-Commerce dataset.

### Tables Analyzed

| Table | Description |
|---|---|
| `customers` | Customer information and geographic locations |
| `orders` | Order details, purchase dates, delivery dates, and order status |
| `order_items` | Product prices, seller associations, and freight charges |
| `products` | Product details and category information |
| `sellers` | Seller information and locations |
| `payments` | Payment types, payment values, and installments |
| `order_reviews` | Customer review scores and feedback-related information |

### SQL Concepts Used

- SELECT, WHERE, ORDER BY, and DISTINCT
- Aggregate functions
- GROUP BY and HAVING
- INNER JOIN and LEFT JOIN
- CASE statements
- Subqueries
- Data filtering and business-focused analytical queries

## 📊 Power BI Dashboard

The interactive dashboard consists of four pages.

### 1. Executive Overview
- Total Orders
- Total Sales Revenue
- Average Order Value
- Total Customers
- Revenue by Product Category
- Revenue Trends
- Payment Value by Payment Type
- Order Status Distribution

### 2. Sales & Product Analysis
- Total Sales Revenue
- Total Order Items
- Average Product Price
- Total Freight
- Top Products by Revenue
- Seller Revenue Analysis
- Product Price Distribution
- Product Price vs. Freight Analysis

### 3. Order & Delivery Analysis
- Order Volume Trends
- Actual vs. Estimated Delivery Days
- Freight Analysis by Product Category
- Order Status Distribution
- Delivery Performance Analysis

### 4. Customer & Payment Insights
- Customer Distribution Across Brazilian States
- Average Payment Value by Payment Method
- Average Installments
- Average Customer Review Score
- State-wise Customer and Order Analysis
- Cancelled Order Analysis

## 🧮 DAX & Calculated Metrics

DAX measures and calculated columns were used to support the dashboard's business calculations.

Key metrics include:

- Total Sales Revenue
- Total Orders
- Total Customers
- Average Order Value
- Total Order Items
- Total Freight
- Average Product Price
- Total Payment Value
- Average Payment Value
- Average Actual Delivery Days
- Average Estimated Delivery Days
- On-Time Delivery Rate

## ⚡ Interactive Features

- Synchronized slicers for State, Order Status, and Date
- Drill-down through date hierarchies
- Interactive charts and KPI cards
- Cross-filtering between visuals
- Page navigation buttons
- Clear Filters functionality
- Geographic customer distribution map
- Consistent dashboard design and formatting

## 💡 Business Questions Explored

- Which product categories generate the highest revenue?
- Which products and sellers contribute most to sales?
- How does revenue change over time?
- How do actual delivery times compare with estimated delivery times?
- How are customers distributed across Brazilian states?
- How do payment values vary by payment method?
- How do customer review scores vary?
- How many orders are cancelled or delivered?

## 🛠️ Tools & Technologies

- **SQL** — Data exploration, querying, joins, and aggregations
- **Microsoft Power BI** — Interactive dashboard development
- **DAX** — Measures and calculated columns
- **Data Modeling** — Relationships between business entities
- **Data Visualization** — KPI cards, charts, tables, and maps

## 📈 Key Learnings

- Applying SQL to business-oriented data analysis.
- Understanding relationships across e-commerce datasets.
- Creating DAX measures for business metrics.
- Designing interactive and user-friendly dashboards.
- Comparing sales, delivery, customer, and payment performance.
- Translating business questions into analytical visualizations.

## 📁 Project Structure

```text
Olist-Ecommerce-Data-Analytics/
│
├── README.md
├── SQL/
│   └── Olist_Analysis.sql
├── PowerBI/
│   └── Olist_Ecommerce_Dashboard.pbix
└── Dashboard_Screenshots/
    ├── Executive_Overview.png
    ├── Sales_Product_Analysis.png
    ├── Order_Delivery_Analysis.png
    └── Customer_Payment_Insights.png

## Dataset

The datasets used in this project are not included in this repository due to file-size limitations.