-- CREATE DATABASE coupon_data;
 USE coupon_data;
 
-- CREATE TABLE coupon_data(
-- destination VARCHAR(50) NULL,
-- passanger VARCHAR(50) NULL,
-- weather VARCHAR(50) NULL,
-- temperature INT NULL,
-- coupon VARCHAR(50) NULL,
-- expiration VARCHAR(50) NULL,
-- gender VARCHAR(50) NULL,
-- age INT NULL,
-- maritalStatus VARCHAR(50) NULL,
-- has_children INT NULL,
-- education VARCHAR(50) NULL,
-- occupation VARCHAR(50) NULL,
-- income VARCHAR(50) NULL,
-- car VARCHAR(50) NULL,
-- Bar VARCHAR(20) NULL,
-- CoffeeHouse VARCHAR(20) NULL,
-- CarryAway VARCHAR(20) NULL,
-- RestaurantLessThan20 VARCHAR(20) NULL,
-- Restaurant20To50 VARCHAR(20) NULL ,
-- toCoupon_GEQ5min INT NULL,
-- toCoupon_GEQ15min INT NULL,
-- toCoupon_GEQ25min INT NULL,
-- direction_same INT NULL,
-- direction_opp INT NULL,
-- Accept INT NULL
-- )

-- 1. Acceptance rate
SELECT 
    COUNT(*) AS total_customers,
    SUM(Accept) AS accepted,
    ROUND(SUM(Accept)/COUNT(*)*100,2) AS acceptance_rate
FROM coupon_data;

-- 2. Acceptance rate by destination
SELECT destination,
       ROUND(AVG(Accept)*100,2) AS acceptance_rate
FROM coupon_data
GROUP BY destination
ORDER BY acceptance_rate DESC;

-- 3. Acceptance by weather
SELECT weather,
       COUNT(*) AS total,
       SUM(Accept) AS accepted,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY weather;

-- 4. Acceptance by temperature
SELECT temperature,
       ROUND(AVG(Accept)*100,2) AS acceptance_rate
FROM coupon_data
GROUP BY temperature;

-- 5. Acceptance by coupon type
SELECT coupon,
       ROUND(AVG(Accept)*100,2) AS acceptance_rate
FROM coupon_data
GROUP BY coupon
ORDER BY acceptance_rate DESC;

-- 6. Acceptance by gender
SELECT gender,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY gender;

-- 7. Acceptance by age group
SELECT age,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY age
ORDER BY rate DESC;

-- 8. Acceptance by income level
SELECT income,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY income
ORDER BY rate DESC;

-- 9. Acceptance by marital status
SELECT maritalStatus,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY maritalStatus;

-- 10. Acceptance by education
SELECT education,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY education;

-- 11. Customers with children vs without
SELECT has_children,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY has_children;

-- 12. Acceptance by occupation
SELECT occupation,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY occupation
ORDER BY rate DESC
LIMIT 10;

-- 13. Acceptance by bar visits
SELECT Bar,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY Bar;

-- 14. Acceptance by coffee house visits
SELECT CoffeeHouse,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY CoffeeHouse;

-- 15. Acceptance by restaurant spending (<20)
SELECT RestaurantLessThan20,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY RestaurantLessThan20;

-- 16. Acceptance by travel time to coupon
SELECT toCoupon_GEQ15min,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY toCoupon_GEQ15min;

-- 17. Acceptance by coupon expiration
SELECT expiration,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY expiration;

-- 18. Acceptance by car ownership
SELECT car,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY car;

-- 19. Top 5 best performing coupon + destination
SELECT coupon, destination,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY coupon, destination
ORDER BY rate DESC
LIMIT 5;

-- 20. Worst performing segments
SELECT coupon, gender, age,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY coupon, gender, age
ORDER BY rate ASC
LIMIT 5;

-- 21. Acceptance by direction same vs opposite
SELECT direction_same,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY direction_same;

-- 22. Customers likely to accept coffee coupons
SELECT age, income,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
WHERE coupon='Coffee House'
GROUP BY age, income
ORDER BY rate DESC;

-- 23. Acceptance trend by passenger type
SELECT passanger,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY passanger;

-- 24. Acceptance by occupation + income
SELECT occupation, income,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY occupation, income
ORDER BY rate DESC
LIMIT 10;

-- 25. Which weather + coupon combo best?
SELECT weather, coupon,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY weather, coupon
ORDER BY rate DESC
LIMIT 10;

-- 26. Acceptance by temperature + time to coupon
SELECT temperature, toCoupon_GEQ25min,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY temperature, toCoupon_GEQ25min;

-- 27. Repeat restaurant visitors acceptance
SELECT Restaurant20To50,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY Restaurant20To50;

-- 28. Best customer persona
SELECT gender, age, income, occupation,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
GROUP BY gender, age, income, occupation
ORDER BY rate DESC
LIMIT 10;

-- 29. Acceptance probability for people without car
SELECT coupon,
       ROUND(AVG(Accept)*100,2) AS rate
FROM coupon_data
WHERE car='None'
GROUP BY coupon;

-- 30. Create view for marketing dashboard
CREATE VIEW coupon_dashboard AS
SELECT coupon,
       COUNT(*) AS total_sent,
       SUM(Accept) AS accepted,
       ROUND(AVG(Accept)*100,2) AS acceptance_rate
FROM coupon_data
GROUP BY coupon;
SELECT * FROM coupon_dashboard;
