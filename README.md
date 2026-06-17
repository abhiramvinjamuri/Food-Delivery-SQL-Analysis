# Food-Delivery-SQL-Analysis
# Smart Delivery Operations Analytics System

A SQL-based business analytics project focused on understanding delivery performance, customer behavior, revenue trends, order cancellations, and delivery partner efficiency for a food delivery platform.

The project uses relational database concepts, SQL queries, Common Table Expressions (CTEs), and window functions to answer real-world business questions and generate actionable insights.

---

## Project Objectives

The analysis focuses on five major business areas:

| Problem Area | Objective |
|-------------|------------|
| Delivery Delays | Identify causes of delayed deliveries and improve operational efficiency |
| Order Cancellations | Understand cancellation patterns and reduce revenue leakage |
| Revenue Optimisation | Discover revenue drivers and growth opportunities |
| Customer Retention | Identify inactive customers and reduce churn |
| Delivery Partner Performance | Evaluate partner efficiency and customer experience |

---

## Dataset Overview

The project uses 7 datasets containing operational data from a food delivery platform.

| Dataset | Records |
|----------|----------:|
| Customers | 1,000 |
| Customer Behavior | 1,000 |
| Restaurants | 100 |
| Orders | 10,000 |
| Payments | 10,000 |
| Ratings | 7,000 |
| Delivery Partners | 200 |

---

## Database Schema

The database consists of the following tables:

| Table Name | Description |
|------------|-------------|
| customers | Customer information |
| customer_behavior | Customer ordering activity and spending patterns |
| restaurants | Restaurant details |
| orders | Order transactions and delivery information |
| payments | Payment details |
| ratings | Customer ratings and feedback |
| delivery_partners | Delivery partner information |

---

## Key SQL Concepts Used

- Joins
- Aggregate Functions
- Group By
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- Date Functions
- Data Cleaning Queries
- Business Analytics Queries

---

## Business Problems Solved

### 1. Delivery Delays

- Restaurants with the highest delivery times
- Delivery partners with the slowest average delivery times
- Cities experiencing delivery delays
- Monthly delivery performance trends

### 2. Order Cancellations

- Restaurants with the highest cancellations
- Cancellation rate by city
- Relationship between delays and cancellations
- Peak cancellation days

### 3. Revenue Optimisation

- Highest revenue generating restaurants
- Revenue contribution by city
- Payment method analysis
- Monthly revenue growth trends

### 4. Customer Retention

- Top customers by lifetime spending
- Most frequent customers
- Inactive customers
- Churn risk classification

### 5. Delivery Partner Performance

- Fastest delivery partners
- Partners with highest successful deliveries
- Partners with highest cancellations
- Partner rating analysis

---

## Sample Insights

| Area | Observation |
|--------|-------------|
| Delivery Delays | Certain restaurants consistently showed higher delivery times than others |
| Order Cancellations | Cancellation rates remained between 10% and 14% across cities |
| Revenue | Chennai and Mumbai generated the highest overall revenue |
| Customer Retention | A significant number of customers had been inactive for more than 90 days |
| Delivery Partners | Performance varied considerably across delivery partners |

---

## Project Structure

```text
Smart-Delivery-Analytics-System
│
├── D1_ER_Diagram.pdf
├── D2_Table_Creation.sql
├── D3_Data_Import_Validation.pdf
├── D4_Data_Cleaning.sql
├── D5_Delivery_Delays.sql
├── D5_Order_Cancellations.sql
├── D5_Revenue_Optimisation.sql
├── D5_Customer_Retention.sql
├── D5_Delivery_Partner_Performance.sql
├── D5_Exploratory_Analysis_Queries.sql
├── D6_Business_Insights_Report.pdf
└── README.md
```

---

## Key Takeaways

This project demonstrates how SQL can be used to solve practical business problems by transforming raw operational data into meaningful insights. The analysis highlights opportunities to improve delivery efficiency, reduce cancellations, strengthen customer retention, optimise revenue, and monitor delivery partner performance.

---

## Author

Abhiram Vinjamuri

SQL • Data Analysis • 

