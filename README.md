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
## Key Findings & Recommendations

### 1. Delivery Delays

**Findings**

The analysis identified a few restaurants with consistently high delivery times. Bombay Hub recorded the highest average delivery time at around 62 minutes. Several Royal restaurants also appeared among the slowest performers.

Delivery partner performance varied noticeably. Some partners took more than 60 minutes on average to complete deliveries, while the fastest partners completed deliveries in less than 50 minutes.

City-level and monthly analysis showed only small differences, suggesting that delays are mainly linked to restaurant operations and delivery partner performance.

**Recommendations**

- Review the operations of the 10 slowest restaurants.
- Monitor delivery partners with consistently high delivery times.
- Improve dispatch and order assignment during peak hours.

---

### 2. Order Cancellations

**Findings**

Some restaurants recorded much higher cancellation counts than others. Classic Point, Royal Corner, Urban Kitchen, and Royal Delight were among the restaurants with the highest cancellations.

Ahmedabad had the highest cancellation rate at 13.49%, while other cities showed similar cancellation levels.

Cancellation volumes were highest on Mondays and Saturdays, indicating increased operational pressure during those days.

The analysis also showed that restaurants with longer delivery times often experienced higher cancellation counts.

**Recommendations**

- Investigate the restaurants with the highest cancellation counts.
- Increase staffing and operational support on Mondays and Saturdays.
- Set up alerts when cancellation rates exceed acceptable limits.

---

### 3. Revenue Optimisation

**Findings**

Taste Kitchen generated the highest total revenue, followed by Star Junction and Golden Express.

At the city level, Chennai and Mumbai contributed the highest revenue. Ahmedabad and Bangalore generated the lowest revenue among the cities analysed.

Customers strongly preferred digital payment methods. UPI generated the highest transaction volume and total revenue.

Monthly revenue changed throughout the two-year period, with some months showing strong growth and others showing declines.

**Recommendations**

- Study the practices of the highest revenue-generating restaurants and apply them where possible.
- Increase marketing efforts in Chennai and Mumbai.
- Encourage digital payments through offers and promotions.
- Develop strategies to improve performance in lower revenue cities.

---

### 4. Customer Retention

**Findings**

Several customers stood out because of their high spending and frequent ordering behaviour. Customers such as Kiran Shah and Amit Verma generated significantly higher lifetime value than the average customer.

The analysis found 350 customers who had not placed an order in more than 90 days. These customers are at risk of leaving the platform permanently.

A long gap since the last order was the strongest indicator of possible customer churn.

**Recommendations**

- Run re-engagement campaigns for inactive customers.
- Create loyalty programs for high-value customers.
- Track customer inactivity and take action before customers become inactive for long periods.
- Send targeted offers to customers who are beginning to reduce their activity.

---

### 5. Delivery Partner Performance

**Findings**

Delivery partner performance varied across the network. Some partners consistently completed deliveries faster and handled higher delivery volumes than others.

Partners such as Sriram Pillai, Deepak Patel, and Harish Pillai were associated with higher cancellation counts.

Customer ratings also varied between partners. The highest-rated partners received average ratings above 3.5, while the lowest-rated partners received ratings below 2.5.

**Recommendations**

- Define performance targets for delivery time and cancellation rates.
- Reward top-performing delivery partners through incentive programs.
- Provide training and support to partners with lower performance.
- Monitor customer ratings regularly and address recurring issues quickly.

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
└── README.md
```
---

Abhiram Vinjamuri

SQL • Data Analysis 

