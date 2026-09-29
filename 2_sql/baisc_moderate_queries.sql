use mobility_analytics;
-- easy queries	
 -- 1. How many users are currently active on the platform?
select * from users
where is_active is True	;

select count(*) as total_active_users from users
where is_active is True	;

-- 2.How many users belong to the city of Delhi?
select * from users
where city_id='del';

select count(*) as total_delhi_users from users
where city_id='del';

-- 3.How many drivers are currently active?
select * from drivers
where is_active is True;

select count(*) as total_active_drivers from drivers
where is_active is True;

-- 4.How many rides have been successfully completed?
select * from rides
where ride_status='completed';

select count(*) as sum_of_completed_rides from rides
where ride_status='completed';

-- 5.How many rides have been cancelled?
select count(*) as sum_of_cancelled_rides from rides
where ride_status='cancelled';

-- 6.How many rides were paid for using cash?
select count(ride_id) as cash_rides from rides
where payment_mode='cash';

-- 7.How many users use each different device_type?
SELECT device_type, COUNT(device_type) AS total_users
FROM users
GROUP BY device_type;

-- 8.What is the average total_fare of all rides?
select avg(total_fare) as average_total_fare
from rides ;

-- 9.What is the total revenue generated from completed rides?
select sum(total_fare) as total_revenue from rides 
where ride_status='completed';

-- 10.How many rides were made using each payment_mode?
SELECT 
    payment_mode,
    COUNT(*) AS total_rides
FROM rides
GROUP BY payment_mode;

-- moderate queries
-- 1.How many users are there in each city?
select city_id,count(user_id) as total_users
from users
group by city_id;

-- 2.What is the total revenue generated from completed rides in each city?
select city_id, sum(total_fare) as total_revenue 
from rides
where ride_status='completed'
group by city_id;

-- 3.Which are the top 5 cities generating the highest revenue from completed rides?
select city_id, sum(total_fare) as total_revenue 
from rides
where ride_status='completed'
group by city_id
order by total_revenue desc limit 5;

-- 4.What is the average rating of drivers in each city?
select city_id,avg(rating) as average_rating
from drivers
group by city_id;

-- 5.How many drivers have a rating greater than 4.5?
select count(*) as high_rating_drivers from drivers
where rating>4.5;

-- 6.How many completed rides have a total_fare greater than ₹500?
select ride_id, total_fare from rides
where ride_status='completed' and total_fare>500;



-- 7.What percentage of all rides were cancelled?
select 
(select count(*) from rides 
where ride_status='cancelled')/count(*)*100
 as percentage_of_cancelled_rides
 from rides;
 
 -- 8.What is the average ride distance for each vehicle type?
 select vehicle_type,avg(distance_km) as average_ride_distance from vehicles as v 
 join rides as r
 on v.vehicle_id=r.vehicle_id
group by vehicle_type;

-- 9.Which payment mode is used for the highest number of rides?
select payment_mode, count(ride_id) as number_of_payments from rides
group by payment_mode
order by number_of_payments desc
limit 1;

-- 10.Who are the top 5 users based on their total number of rides?
select u.user_id,count(*) as total_rides 
from users as u 
join rides as r
on u.user_id=r.user_id
group by u.user_id
order by total_rides desc
limit 5;