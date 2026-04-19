-- NYC Airbnb Market Analysis
-- Author: Lalita Gupta
-- Dataset: NYC Airbnb Open Data 2019 (48,895 listings)

-- Query 1: Average price by borough and room type
SELECT 
    neighbourhood_group AS borough,
    room_type,
    ROUND(AVG(price), 2) AS avg_price,
    COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood_group, room_type
ORDER BY avg_price DESC;

-- Query 2: Top 10 hosts by number of listings
SELECT 
    host_id,
    host_name,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price,
    SUM(number_of_reviews) AS total_reviews
FROM listings
GROUP BY host_id, host_name
ORDER BY total_listings DESC
LIMIT 10;

-- Query 3: Borough availability and pricing analysis
SELECT 
    neighbourhood_group AS borough,
    ROUND(AVG(availability_pct), 2) AS avg_availability_pct,
    ROUND(AVG(price), 2) AS avg_price,
    COUNT(*) AS total_listings,
    SUM(CASE WHEN availability_365 = 0 THEN 1 ELSE 0 END) AS fully_booked_listings
FROM listings
GROUP BY neighbourhood_group
HAVING avg_availability_pct > 0
ORDER BY avg_availability_pct DESC;

-- Query 4: Price quartiles by borough using window function
SELECT 
    neighbourhood_group AS borough,
    price,
    NTILE(4) OVER (PARTITION BY neighbourhood_group ORDER BY price) AS price_quartile,
    ROUND(AVG(price) OVER (PARTITION BY neighbourhood_group), 2) AS borough_avg_price,
    ROUND(AVG(price) OVER (), 2) AS overall_avg_price
FROM listings
ORDER BY neighbourhood_group, price;

-- Query 5: Host concentration analysis using CTE
WITH host_stats AS (
    SELECT 
        host_id,
        host_name,
        neighbourhood_group AS borough,
        COUNT(*) AS listing_count,
        ROUND(AVG(price), 2) AS avg_price,
        SUM(number_of_reviews) AS total_reviews
    FROM listings
    GROUP BY host_id, host_name, neighbourhood_group
),
borough_stats AS (
    SELECT
        borough,
        COUNT(DISTINCT host_id) AS total_hosts,
        SUM(listing_count) AS total_listings,
        ROUND(AVG(avg_price), 2) AS borough_avg_price
    FROM host_stats
    GROUP BY borough
)
SELECT 
    h.borough,
    h.host_name,
    h.listing_count,
    h.avg_price,
    b.total_hosts,
    b.total_listings,
    ROUND(CAST(h.listing_count AS FLOAT) / b.total_listings * 100, 2) AS pct_of_borough_listings
FROM host_stats h
JOIN borough_stats b ON h.borough = b.borough
WHERE h.listing_count > 5
ORDER BY h.listing_count DESC
LIMIT 20;