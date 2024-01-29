-- Question 3. Count records
-- How many taxi trips were totally made on September 18th 2019?
-- Tip: started and finished on 2019-09-18.
-- Remember that lpep_pickup_datetime and lpep_dropoff_datetime columns are in the format timestamp (date and hour+min+sec) and not in date.

select count(*) from green_taxi_data 
where date(lpep_pickup_datetime) = '2019-09-18' and 
date(lpep_dropoff_datetime) = '2019-09-18';

-- Question 4. Largest trip for each day
-- Which was the pick up day with the largest trip distance Use the pick up time for your calculations.

select max(trip_distance) as trip_dis, date(lpep_pickup_datetime) 
from green_taxi_data 
group by date(lpep_pickup_datetime) 
order by trip_dis desc;

-- Question 5. Three biggest pick up Boroughs
-- Consider lpep_pickup_datetime in '2019-09-18' and ignoring Borough has Unknown
-- Which were the 3 pick up Boroughs that had a sum of total_amount superior to 50000?

select sum(trips.total_amount)as amt, taxi_zone."Borough"
from green_taxi_data as trips 
LEFT JOIN taxi_zone on  trips."PULocationID" = taxi_zone."LocationID" 
where date(lpep_pickup_datetime) = '2019-09-18' 
group by taxi_zone."Borough" having sum(trips.total_amount) > 50000;

 
-- Question 6. Largest tip
-- For the passengers picked up in September 2019 in the zone name Astoria which was the drop off zone that had the largest tip? We want the name of the zone, not the id.
-- Note: it's not a typo, it's tip , not trip

SELECT dropoff_zone."Zone", max(trip."tip_amount") as largest_tip
FROM green_taxi_data as trip
left join taxi_zone as pickup_zone on trip."PULocationID" = pickup_zone."LocationID"
left join taxi_zone as dropoff_zone on trip."DOLocationID" = dropoff_zone."LocationID" 
where 
 trim(to_char(trip."lpep_pickup_datetime", 'Month')) = 'September' 
 and pickup_zone."Zone" = 'Astoria'
GROUP BY 
    dropoff_zone."Zone"
order by largest_tip desc