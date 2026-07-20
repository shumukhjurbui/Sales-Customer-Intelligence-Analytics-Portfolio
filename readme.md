##### **# 📊 Sales \& Customer Intelligence Analytics Portfolio**

An end-to-end Data Analytics project featuring a relational database setup, SQL queries, DAX measure modeling, and an interactive 4-page Power BI dashboard designed to deliver business insights for executive decision-making.



\---



**## 🌟 Executive Summary**



This project provides an in-depth analysis of sales performance, customer demographics, and product performance. By leveraging SQL for data aggregation and Power BI for data modeling and interactive visualization, the project transforms raw transactional data into actionable corporate strategy.

\---

&#x20;

**## 🗄️ SQL Highlights \& Data Modeling**



Here is a sample SQL script used for creating relational tables and aggregating KPIs:



```sql

\-- Creating FactSales Table

CREATE TABLE FactSales (

&#x20;   SalesKey INT PRIMARY KEY,

&#x20;   CustomerKey INT,

&#x20;   ProductKey INT,

&#x20;   DateKey INT,

&#x20;   Quantity INT,

&#x20;   Revenue DECIMAL(10,2),

&#x20;   FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),

&#x20;   FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey)

);



\-- Querying Revenue by Category

SELECT 

&#x20;   p.Category,

&#x20;   SUM(f.Revenue) AS TotalRevenue,

&#x20;   COUNT(DISTINCT f.SalesKey) AS TotalOrders

FROM FactSales f

JOIN DimProduct p ON f.ProductKey = p.ProductKey

GROUP BY p.Category

ORDER BY TotalRevenue DESC;

```

\---



**## 🚀 Key Features \& Pages**



The Power BI report consists of \*\*4 interactive pages\*\*:



1\. \*\*Executive Sales Performance Overview:\*\* High-level summary featuring regional slicers, KPI metrics, sales trends, and category performance.

2\. \*\*Customer Behavior \& Demographics Analysis:\*\* Granular analysis of top revenue-generating customers, city-level demographics, and acquisition trends.

3\. \*\*Product Performance \& Inventory Insights:\*\* Detailed performance tracking of top products, category share, and low-performing inventory for stock optimization.

4\. \*\*Time Series \& Sales Trend Analysis:\*\* Dynamic time-series evaluation focusing on monthly revenue, transaction volume, and seasonal patterns.



\---



**## 🛠️ Tech Stack \& Skills Demonstrated**



\* \*\*Data Modeling \& DAX:\*\* Created measures for Total Sales, Total Orders, Average Order Value (AOV), Total Quantity, and Customer Counts (`DISTINCTCOUNT`, `SUM`, filtering logic).

\* \*\*Power BI Desktop:\*\* Multi-page dashboard layout, custom color palettes, interactive cross-filtering, and slicers.

\* \*\*SQL:\*\* Relational database structuring, joins, and data querying.

\* \*\*Business Intelligence:\*\* KPI tracking, trend analysis, inventory optimization, and customer segmentation.



\---



**## 📸 Dashboard Screenshots**



\### Page 1: Executive Sales Performance Overview

!\[Executive Overview](Images/Dashboard\_Executive\_Overview.png)



\### Page 2: Customer Behavior \& Demographics Analysis

!\[Customer Analysis](Images/Dashboard\_Customer\_Analysis.png)



\### Page 3: Product Performance \& Inventory Insights

!\[Product Analysis](Images/Dashboard\_Product\_Analysis.png)



\### Page 4: Time Series \& Sales Trend Analysis

!\[Time Series Analysis](Images/Dashboard\_Time\_Series\_Analysis.png)



\---



**## 💡 Key Business Insights**



\* \*\*Category Leadership:\*\* Electronics drives over \*\*72%\*\* of overall company revenue, serving as the core profit engine.

\* \*\*Geographic Distribution:\*\* Revenue is evenly balanced across key operational hubs (\*\*Jeddah: 33.94%\*\*, \*\*Riyadh: 33.77%\*\*, \*\*Dammam: 32.29%\*\*).

\* \*\*Account Concentration:\*\* Top 10 primary accounts generate the vast majority of high-margin transactions.



\---



**## 📁 Repository Structure**



├── 📁 Images/                            

│   ├── Dashboard\_Executive\_Overview.png      

│   ├── Dashboard\_Customer\_Analysis.png

│   ├── Dashboard\_Product\_Analysis.png

│   ├── Dashboard\_Time\_Series\_Analysis.png

│   ├── sql\_query\_01\_total\_sales.png        

│   ├── sql\_query\_02\_revenue\_by\_category.png

│   ├── sql\_query\_03\_top\_customers.png

│   ├── sql\_query\_04\_city\_sales.png

│   ├── sql\_query\_05\_top\_products.png

│   └── sql\_query\_06\_monthly\_trend.png

│

├── 📜 database\_setup\_and\_queries.sql         

├── 📊 Sales\_\&\_Customer\_Intelligence\_Dashboard\_2026.pbix 

├── 📄 Executive\_Sales\_\&\_Customer\_Report\_2026.pdf       

└── 📝 README.md                            

