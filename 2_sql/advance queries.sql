-- 1.Which cities have generated more than ₹1,00,000 in revenue from completed rides?
select city_id, sum(total_fare) as total_revenue 
from rides
where ride_status='completed'
group by city_id
having sum(total_fare)>100000;

-- 2.Which drivers have completed more than 50 rides?
select d.driver_id,count(ride_id) as total_rides
from drivers as d
join rides as r 
on d.driver_id=r.driver_id
where r.ride_status='completed'
group by driver_id
having count(ride_id)>50;

-- 3.Which drivers have a cancellation rate below 5%?
select driver_id, name, cancellation_rate from drivers 
where cancellation_rate <5;

-- 4.What is the total revenue generated in each month from completed rides? 
select year(pickup_time) as year, month(pickup_time) as month,sum(total_fare) as total_revenue 
from rides
where ride_status='completed'
group by month(pickup_time), year(pickup_time)
order by year, month ;

-- 5.Which hour of the day has the highest number of rides?
select hour(pickup_time) as ride_hour,
count(ride_id) as total_rides
from rides
group by hour(pickup_time)
order by total_rides desc
limit 1;

-- 6.What is the total amount spent by each user on completed rides?
select u.user_id,u.name,sum(r.total_fare) as total_spent
from rides as r
join users as u
on r.user_id=u.user_id
where ride_status='completed'
 group by u.user_id, u.name ;
 
 -- 7.Which users have spent more than ₹1000 on completed rides?
 select u.user_id,u.name,sum(r.total_fare) as total_spent
from rides as r
join users as u
on r.user_id=u.user_id
where ride_status='completed'
group by u.user_id
having sum(r.total_fare) >1000;

-- 8.Which vehicle type has the highest average fare per ride?
select v.vehicle_type, avg(total_fare) as avg_total_fare from
vehicles as v
join rides as r
on v.vehicle_id=r.vehicle_id
group by vehicle_type
order by avg(total_fare) desc
limit 1;

-- 9.How much total discount was given through each promotion campaign?
select campaign_name, sum(discount_amt) as total_discount
from promotions
group by campaign_name;

-- 10.Find the top 5 drivers based on their completed rides, showing:Driver ID ,Driver name, Completed rides, Average rating
select driver_id, name, total_rides_completed as total_rides, rating as avg_rating
from drivers
order by total_rides desc
limit 5;
