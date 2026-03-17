#Total Revenue
select * from bookings;
Select sum(revenue_realized) as Total_Revenue
from bookings;

-- Total Bookings
Select count(*) as Total_Bookings
from bookings;

-- Total Capacity
select sum(Capacity) Total_Capacity from aggregated_bookings;

-- Total Revenue by City
select concat(round(sum(b.revenue_realized) / 1000000, 1), ' M') Total_Revenue, h.city as City 
from bookings b
join hotels h on b.property_id = h.property_id
group by h.city;


-- Total Revenue by Day_Type (Weekend/Weekday)
select 
    concat(round(sum(b.revenue_realized)/1000000,1),' M') as Total_Revenue,
    d.day_type as Day_Type
from bookings b
join date d
    on b.check_in_date = str_to_date(d.date, '%d-%b-%y')
group by d.day_type;

-- total number of "Cancelled" bookings
SELECT COUNT(*) AS Total_Cancelled_Bookings
FROM bookings
WHERE booking_status = 'Cancelled';

-- total number of successful bookings
SELECT SUM(successful_bookings) AS Total_Successful_Bookings
FROM aggregated_bookings;


-- Revenue by Property Name

Select h.property_name, Sum(revenue_realized) as Total_revenue
from bookings b
join hotels h on b.property_id = h.property_id
group by h.property_name
order by 2 desc;


-- Rank Properties by Revenue (Overall)

select h.property_name as Property_name, sum(b.revenue_realized) as Total_Revenue,
rank() over (order by sum(b.revenue_realized) desc) as Revenue_rank
from bookings b join hotels h
on b.property_id = h.property_id
group by h.property_name;

