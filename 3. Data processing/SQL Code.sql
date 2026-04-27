-- view all table fields/ columns and maximun 50 rows
select * from workspace.default.bright_coffee_shop_analysis limit 50; 

--show unique data without duplicates
select distinct store_location 
from Bright_Coffee_Shop_Analysis;

--view specific columns
select transaction_id,
       transaction_date,
       store_location,
       product_category
from Bright_Coffee_Shop_Analysis;

--aggregate SUM
select distinct store_location,
       sum(transaction_qty * unit_price) as store_revenue
from Bright_Coffee_Shop_Analysis
group by store_location;    

--aggregate AVARAGE. Using alias
select distinct store_location,
       avg(transaction_qty * unit_price) as store_AVG_revenue
from Bright_Coffee_Shop_Analysis
group by store_location;   

select max(unit_price ) as high_price,
       min(unit_price ) as Low_price
from Bright_Coffee_Shop_Analysis;

--- filters using where
select *
from Bright_Coffee_Shop_Analysis
where product_category = 'Tea'
and unit_price >= 1 and unit_price < 3.1;

-- Updated final code

SELECT 
    DATE_FORMAT(transaction_date, 'dd MMM yyyy') AS transaction_date,
    DATE_FORMAT(transaction_time, 'HH:mm:ss') AS Trans_time,
    DAYNAME(transaction_date) AS Day_Name,
    MONTHNAME(transaction_date) AS Month_Name,
    CASE 
        WHEN MONTHNAME(transaction_date) = 'Jan' THEN 1
        WHEN MONTHNAME(transaction_date) = 'Feb' THEN 2
        WHEN MONTHNAME(transaction_date) = 'Mar' THEN 3
        WHEN MONTHNAME(transaction_date) = 'Apr' THEN 4
        WHEN MONTHNAME(transaction_date) = 'May' THEN 5
        WHEN MONTHNAME(transaction_date) = 'Jun' THEN 6
    END AS Month_Sort,
    store_location,
    CASE 
        WHEN store_location = 'Astoria' THEN 1 
        WHEN store_location = 'Lower Manhattan' THEN 2 
        ELSE 3 
    END AS store_sort,
    CASE
        WHEN DAYNAME(transaction_date) IN ('Sun' , 'Sat') THEN 'Weekend' 
        ELSE 'Weekday'
    END AS Week_sales,
    CASE
        WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_buckets,
    product_category,
    product_type,
    product_detail,
    COUNT(DISTINCT transaction_id) AS number_of_sales,
    COUNT(DISTINCT product_id) AS number_of_products,
    COUNT(DISTINCT store_id) AS number_of_stores,
    SUM(transaction_qty * unit_price) AS Total_amount,
    CASE
        WHEN SUM(transaction_qty * unit_price) <= 50 THEN 'Low Spend'
        WHEN SUM(transaction_qty * unit_price) BETWEEN 51 AND 109 THEN 'Med Spend'
        ELSE 'High Spend'
    END AS spend_bucket,
    CASE 
        WHEN DAYNAME(transaction_date) = 'Mon' THEN 1
        WHEN DAYNAME(transaction_date) = 'Tue' THEN 2
        WHEN DAYNAME(transaction_date) = 'Wed' THEN 3
        WHEN DAYNAME(transaction_date) = 'Thu' THEN 4
        WHEN DAYNAME(transaction_date) = 'Fri' THEN 5
        WHEN DAYNAME(transaction_date) = 'Sat' THEN 6
        ELSE 7 
    END AS DayName_Sort,
    DAY(transaction_date) AS day_sort
FROM Bright_Coffee_Shop_Analysis
GROUP BY 
    transaction_date,
    transaction_time,
    store_location,
    product_category,
    product_type,
    product_detail;

