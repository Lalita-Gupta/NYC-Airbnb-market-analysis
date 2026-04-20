# NYC Airbnb Market Analysis

## Project Overview
Exploratory data analysis of 48,000+ NYC Airbnb listings using Python, 
SQL, and Tableau to surface borough-level pricing trends, availability 
patterns, and host concentration insights.

**Tools:** Python (Pandas, NumPy, Matplotlib, Seaborn), SQLite, SQL, Tableau  
**Dataset:** NYC Airbnb Open Data 2019 — 48,895 listings across 5 boroughs

---

## Key Findings

**1. Manhattan commands a 35% price premium**  
Entire homes in Manhattan average $229/night vs $170 in Brooklyn — 
same room type, same city, 35% price difference driven purely by location.

**2. High price = low availability**  
Manhattan has only 30.6% availability — 70% of listings are booked or 
blocked. Staten Island has 54.6% availability but the lowest average price.
Clear inverse relationship between price and availability.

**3. Professional hosts dominate Manhattan**  
Top host Sonder (NYC) controls 327 listings — 1.52% of all Manhattan 
inventory — at $253/night average. Professional property managers are 
crowding out individual hosts in high-demand boroughs.

---

## Files in this Repository

| File | Description |
|------|-------------|
| `airbnb_analysis.ipynb` | Full analysis notebook — cleaning, EDA, visualisations |
| `queries.sql` | 5 SQL queries — window functions, CTEs, aggregations |
| `airbnb_clean.csv` | Cleaned dataset after outlier removal and feature engineering |
| `borough_price.png` | Average price by borough chart |
| `room_type.png` | Room type distribution pie chart |
| `top_neighbourhoods.png` | Top 10 most expensive neighbourhoods |

---

## Data Cleaning Steps
- Removed 0-price listings (invalid data)
- Capped prices at $1,500/night (removed extreme outliers)
- Filled missing `reviews_per_month` with 0 (new listings with no reviews)
- Engineered 3 new features: `availability_pct`, `price_per_min_nights`, `review_score_bin`

---

## SQL Queries Included
1. Average price by borough and room type (GROUP BY, AVG)
2. Top 10 hosts by listing count (GROUP BY, COUNT, ORDER BY)
3. Borough availability and pricing analysis (CASE WHEN, HAVING)
4. Price quartiles by borough (NTILE window function)
5. Host concentration analysis (CTE with JOIN)

---

## Dashboard
Interactive Tableau dashboard with borough filter, map view, 
room-type breakdown, and KPI cards.  
[View Live Dashboard](https://public.tableau.com/views/NYC-Airbnb-Market-Analysis-Lalita-Gupta/NYCAirbnbMarketAnalysisInteractiveDashboard)

---

## How to Run
```bash
git clone https://github.com/Lalita-Gupta/nyc-airbnb-analysis
cd nyc-airbnb-analysis
pip install pandas numpy matplotlib seaborn jupyter
jupyter notebook airbnb_analysis.ipynb
```
