SELECT * FROM swiggy_data;

--Data Cleaning and Validation
--Null Check
SELECT 
	SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS null_state,
	SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS null_city,
	SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
	SUM(CASE WHEN Restaurant_Name IS NULL THEN 1 ELSE 0 END) AS null_restaurant_name,
	SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS null_location,
	SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS null_category,
	SUM(CASE WHEN Dish_Name IS NULL THEN 1 ELSE 0 END) AS null_dish_name,
	SUM(CASE WHEN Price_INR IS NULL THEN 1 ELSE 0 END) AS null_price_inr,
	SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
	SUM(CASE WHEN Rating_Count IS NULL THEN 1 ELSE 0 END) AS null_rarting_count
FROM swiggy_data;

--Blank or Empty String
SELECT *
FROM swiggy_data 
WHERE 
	State='' OR 
	City='' OR 
	Restaurant_Name='' OR 
	Location='' OR
	Category='' OR 
	Dish_Name='';

--Duplicate Detection
SELECT 
	State, City, Order_Date, Restaurant_Name, Location, Category, Dish_Name, Price_INR, Rating, Rating_Count, COUNT(*) AS CNT
FROM swiggy_data
GROUP BY
	State, City, Order_Date, Restaurant_Name, Location, Category, Dish_Name, Price_INR, Rating, Rating_Count
HAVING COUNT(*) > 1;

--Delete Duplicate records 
-- If we have id then go for id + delete join
DELETE t1
FROM swiggy_data t1
JOIN swiggy_data t2
ON 
	t1.State = t2.State AND
	t1.City = t2.City AND
	t1.Order_Date = t2.Order_Date AND
	t1.Restaurant_Name = t2.Restaurant_Name AND
	t1.Location = t2.Location AND
	t1.Category = t2.Category AND
	t1.Dish_Name = t2.Dish_Name AND
	t1.Price_INR = t2.Price_INR AND
	t1.Rating = t2.Rating AND
	t1.Rating_Count = t2.Rating_Count AND
	t1.id > t2.id
-- As we dont have id then create new table 
SELECT DISTINCT *
INTO swiggy_clean
FROM swiggy_data;

DROP TABLE swiggy_data;
EXEC sp_rename 'swiggy_clean', 'swiggy_data';


