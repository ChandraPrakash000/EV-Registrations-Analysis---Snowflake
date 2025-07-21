# ⚡ Electric Vehicle Registrations Analysis – Snowflake SQL Project

#This project presents a SQL-based analysis of Electric Vehicle (EV) Registration Data sourced from the Snowflake Marketplace. The goal is to explore trends in EV adoption across the United States using Snowflake’s cloud data platform and Snowsight worksheets.

## 📦 Data Source
Dataset: ELECTRIC_VEHICLES_DATA_TRENDS.INSIGHTS.ALL_STATE_VEHICLE_MODEL_REGISTRATION_COUNTS_PER_YEAR
Provider: Snowflake Marketplace
Description: Contains detailed records of electric vehicle registrations across U.S. states, including vehicle make, model, drivetrain type, registration dates, and more.

## 🧰 Tools & Technologies
Snowflake – Cloud data warehouse for SQL querying
Snowsight – Snowflake’s web-based worksheet and visualization tool
SQL – For data exploration, aggregation, and trend analysis

## 🔍 Key Analyses Performed
### ✅ General Trends
Total EV registrations per year
Registration trends over time using DMV snapshot dates
### ✅ Vehicle Insights
List of all distinct vehicle makes
Top 5 most common vehicle makes (basic and ranked)
Vehicles with missing model names or drivetrain types
### ✅ Geographic Analysis
Vehicle count per state
Latest DMV snapshot date per state
States where light-duty vehicles are more common than heavy-duty
### ✅ Technical Insights
Vehicle distribution by drivetrain type per state
Vehicle category percentage within each state
Vehicle category distribution (Light, Medium, Heavy)
### ✅ Time-Based Analysis
Registrations after a specific date (e.g., 2024-01-01)
Registrations expiring within the next 30 days
EVs with valid registrations beyond a certain date (e.g., 2025-01-01)
### ✅ Advanced Queries
Ranking vehicle models by popularity within each state
Using CTEs and window functions for deeper insights

## 📂 Project Structure
├── sql_queries/
│   └── ev_analysis_queries.sql
├── README.md

## 📈 Sample Questions Answered
How many EVs were registered each year?
Which vehicle makes are most popular?
What is the distribution of drivetrain types across states?
Which states have the highest number of EVs?
How many registrations are expiring soon?

## ✅ Outcomes
Identified top-performing states and vehicle makes
Detected data quality issues (e.g., missing model names)
Used advanced SQL techniques (CTEs, window functions, ranking)
Gained insights into EV adoption trends and regional preferences
