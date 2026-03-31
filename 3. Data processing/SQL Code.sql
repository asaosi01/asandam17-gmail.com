
SELECT
    transaction_date,
    date_format(transaction_time, 'HH:mm:ss') AS Trans_time,
    dayname(transaction_date) AS Day_Name,
    monthname(transaction_date) AS Month_Name,
    -- Categorical columns
    store_location,
    CASE 
        WHEN store_location = 'Astoria' THEN 1 
        WHEN store_location = 'Lower Manhattan' THEN 2 
        ELSE 3 
    END AS store_sort,
    CASE
        WHEN Day_Name IN ('Sun' , 'Sat') THEN 'Weekend' ELSE 'Weekday'
        END AS Week_sales,
    CASE
        WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN date_format(transaction_time, 'HH:mm: ss' ) BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
        WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN 'Evening'
        END AS time_buckets,
    product_category,
    product_type,
    product_detail,
    COUNT(DISTINCT transaction_id) AS Number_of_sales,
    COUNT(DISTINCT product_id) AS number_of_products,
    COUNT(DISTINCT store_id) AS number_of_stores,
    -- Revenue
    SUM(transaction_qty * unit_price) AS Total_amount,
    CASE
        WHEN Total_amount <= 50 THEN 'Low Spend'
        WHEN Total_amount BETWEEN 51 AND 109 THEN 'Med Spend'
        ELSE 'High Spend'
        END AS spend_bucket
FROM Bright_Coffee_Shop_Analysis
GROUP BY
    transaction_date,
    Trans_time,
    dayname(transaction_date),
    monthname(transaction_date),
    store_location,
    store_sort,
   CASE
        WHEN Day_Name IN ('Sun' , 'Sat') THEN 'Weekend' ELSE 'Weekday'
        END,
    time_buckets,
    product_category,
    product_type,
    product_detail;