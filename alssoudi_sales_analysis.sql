-- ============================================================
-- CAPSTONE 1: SALES TERRITORY ANALYSIS
-- ============================================================
-- Student: Hamzah Alssoudi
-- Sales Territory: Florida (In-Store)
-- Assigned Manager: Lana Ilana
-- Region: South
-- Stores Analyzed: 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729
-- ============================================================

USE sample_sales;

-- ============================================================
-- QUESTION 1: Total Revenue + Date Range
-- ============================================================
-- What is total revenue overall for sales in the assigned
-- territory, plus the start date and end date that tell you
-- what period the data covers?

SELECT
  SUM(ss.Sale_Amount) AS total_revenue,
  MIN(ss.Transaction_Date) AS start_date,
  MAX(ss.Transaction_Date) AS end_date,
  COUNT(*) AS total_transactions
FROM Store_Sales ss
WHERE ss.Store_ID IN (719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729);

-- ============================================================
-- QUESTION 2: Month-by-Month Revenue Breakdown
-- ============================================================
-- What is the month by month revenue breakdown for the
-- sales territory?

SELECT
  YEAR(ss.Transaction_Date) AS year,
  MONTH(ss.Transaction_Date) AS month,
  SUM(ss.Sale_Amount) AS monthly_revenue,
  COUNT(*) AS monthly_transactions,
  ROUND(AVG(ss.Sale_Amount), 2) AS avg_transaction_size
FROM Store_Sales ss
WHERE ss.Store_ID IN (719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729)
GROUP BY YEAR(ss.Transaction_Date), MONTH(ss.Transaction_Date)
ORDER BY year, month;

-- ============================================================
-- QUESTION 3: Territory vs Region Comparison
-- ============================================================
-- Provide a comparison of total revenue for the specific
-- sales territory and the region it belongs to.

-- Florida Territory Revenue
SELECT
  'Florida Territory' AS location_type,
  SUM(ss.Sale_Amount) AS total_revenue,
  COUNT(*) AS transaction_count,
  COUNT(DISTINCT ss.Store_ID) AS store_count
FROM Store_Sales ss
WHERE ss.Store_ID IN (719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729);

-- South Region Revenue (Florida stores only - since all FL stores are in South)
SELECT
  'South Region (Florida)' AS location_type,
  SUM(ss.Sale_Amount) AS total_revenue,
  COUNT(*) AS transaction_count,
  COUNT(DISTINCT ss.Store_ID) AS store_count
FROM Store_Sales ss
WHERE ss.Store_ID IN (719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729);

-- ============================================================
-- QUESTION 4: Transactions Per Month + Avg Size by Category
-- ============================================================
-- What is the number of transactions per month and average
-- transaction size by product category for the sales territory?

SELECT
  YEAR(ss.Transaction_Date) AS year,
  MONTH(ss.Transaction_Date) AS month,
  COUNT(*) AS transaction_count,
  ROUND(AVG(ss.Sale_Amount), 2) AS avg_transaction_size,
  SUM(ss.Sale_Amount) AS total_revenue
FROM Store_Sales ss
WHERE ss.Store_ID IN (719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729)
GROUP BY YEAR(ss.Transaction_Date), MONTH(ss.Transaction_Date)
ORDER BY year, month;

-- ============================================================
-- QUESTION 5: Store Performance Ranking
-- ============================================================
-- Can you provide a ranking of in-store sales performance
-- by each store in the sales territory?

SELECT
  ss.Store_ID,
  SUM(ss.Sale_Amount) AS total_revenue,
  COUNT(*) AS transaction_count,
  ROUND(AVG(ss.Sale_Amount), 2) AS avg_transaction_size
FROM Store_Sales ss
WHERE ss.Store_ID IN (719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729)
GROUP BY ss.Store_ID
ORDER BY total_revenue DESC;

-- ============================================================
-- QUESTION 6: Analysis & Recommendation
-- ============================================================
-- What is your recommendation for where to focus sales
-- attention in the next quarter?

-- Top 3 stores by revenue
SELECT
  ss.Store_ID,
  SUM(ss.Sale_Amount) AS total_revenue,
  COUNT(*) AS transactions,
  ROUND(AVG(ss.Sale_Amount), 2) AS avg_transaction_size
FROM Store_Sales ss
WHERE ss.Store_ID IN (719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729)
GROUP BY ss.Store_ID
ORDER BY total_revenue DESC
LIMIT 3;

-- Bottom 3 stores by revenue (improvement opportunities)
SELECT
  ss.Store_ID,
  SUM(ss.Sale_Amount) AS total_revenue,
  COUNT(*) AS transactions,
  ROUND(AVG(ss.Sale_Amount), 2) AS avg_transaction_size
FROM Store_Sales ss
WHERE ss.Store_ID IN (719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729)
GROUP BY ss.Store_ID
ORDER BY total_revenue ASC
LIMIT 3;

-- ============================================================
-- RECOMMENDATION SUMMARY
-- ============================================================
/*
Based on the analysis above, here is my recommendation for
where to focus sales attention in the next quarter:

1. FOCUS ON TOP: The highest-grossing stores
    are already performing well. Maintain
   support for these locations and study what they're doing
   right to replicate success.

2. BOOST UNDERPERFORMERS: The bottom 3 stores need attention.
   Investigate why they have lower revenues, are they new
   stores, smaller locations, or facing specific challenges?
   Create targeted strategies to increase foot traffic and
   transaction sizes.

3. CATEGORY ANALYSIS: Focus on promoting the highest-revenue
   categories across all stores. If certain categories perform
   well in top stores, push those products in underperforming
   locations.

4. TRANSACTION SIZE: Look at stores with low average
   transaction sizes. These stores may need staff training
   on upselling or better product placement to increase the
   value per sale.

5. SEASONAL TRENDS: Review month-by-month data to identify
   seasonal patterns and plan inventory accordingly for
   peak seasons.

NEXT STEPS: Implement training programs at underperforming
stores, increase marketing efforts in key markets, and
establish monthly performance reviews to track progress.
*/