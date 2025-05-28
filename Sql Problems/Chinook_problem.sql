use Chinook;

/* 1. Retrieve Unique Genres
Objective: List all unique genres available in the Genre table.  */


select distinct Name from Genre;

/*
2. Filter Customers by Country
Objective: Retrieve all customers from Canada whose first name starts with 'A'.
*/


select * from Customer where Country = 'Canada' and FirstName like 'A%';


/*
3. Aggregate Sales by Country
Objective: Calculate the total sales (Total) per country from the Invoice table.
*/

select distinct cus.Country,   sum(Total) over(partition by cus.Country ) as pricedd from Invoice as inv join Customer as cus on inv.Customerid = cus.Customerid  ;


/*
4. Customers with High Spending
Objective: List customers who have spent more than $50 in total.

*/

select cus.Customerid, cus.FirstName,prr from (select customerid , sum(Total ) as prr from Invoice group by customerid) as prrr join Customer as cus on cus.Customerid = prrr.customerid ;



/*

5. Top 5 Customers by Spending
Objective: Identify the top 5 customers based on their total spending.

*/


select cus.FirstName, top.Customerid, top.price from (select Customerid,sum(Total) as price from Invoice group by Customerid order by price desc limit 5) as top join Customer as cus on cus.Customerid = top.Customerid;




/*

6. Join Tracks with Album and Artist
Objective: Retrieve track names along with their corresponding album titles and artist names.

*/


select trk.Trackid,trk.Name, trk.Albumid, row_number() Over() as num, Title from Track as trk join Album as alb on  Alb.Albumid = Trk.Albumid order by Trk.Trackid ;


/*
 7. Albums Without Tracks
Objective: List all albums that do not have any tracks associated with them.
*/


select Trackid from Track where Albumid not between 1 and 347 ;

select count(distinct Albumid) from Track order by Albumid;


/*
8. Employee Hierarchy
Objective: Using a self join, list employees along with their managers' names.

*/



select  A.LastName as emp , B.LastName as man from Employee as A join Employee as B on A.ReportsTo = B.Employeeid  ;



/*
9. Combine Billing and Shipping Cities
Objective: Create a combined list of all billing and shipping cities (assuming shipping city data is available).
*/



select BillingCity from Invoice union select City from Customer ;


/*
10. Track Name Lengths
Objective: List track names along with their name lengths.
*/



select Name,length(Name) from Track;


/*
11. Trimmed Customer Names
Objective: Display customer first and last names after trimming any leading or trailing spaces.

*/



select concat(trim(FirstName),' ' , trim(LastName)) from Customer;



/*
12. Categorize Tracks by Length
Objective: Use a CASE statement to categorize tracks as 'Short', 'Medium', or 'Long' based on their duration.
*/


select avg(Milliseconds) from Track;

select * from Track;
select 
Milliseconds,
case
   when Milliseconds < '393599.2121'/2 then 'low'
   when Milliseconds >= '393599.2121'/2 and Milliseconds <= '393599.2121' then 'medium'
   else 'high'
  end as category
 from Track; 



/*
13. Customers Above Average Spending
Objective: List customers who have spent more than the average total spending of all customers.

*/



select coll.Customerid, cus.FirstName, coll.tol  from (select distinct Customerid, sum(Total)over(partition by Customerid) as tol from Invoice) as coll join Customer as cus on Cus.Customerid=coll.Customerid;




/*
14. Running Total of Sales
Objective: Calculate a running total of sales over time.
*/


select InvoiceDate,sum(Total) from Invoice group by InvoiceDate;



/*
15. Monthly Sales Rolling Average
Objective: Compute a 3-month rolling average of sales per country.
*/



select distinct * from 
(select BillingState,  sum(Total) from Invoice where InvoiceDate like '2025_01%' group by BillingState 
union 
select BillingState, sum(Total)  from Invoice where InvoiceDate like '2025_02%' group by BillingState
union 
select BillingState, sum(Total)   from Invoice where InvoiceDate like '2025_03%' group by BillingState ) 
as mon ;



/*
16. Rank Tracks by Duration
Objective: Assign row numbers to tracks within each album, ordered by duration.

*/



select Albumid, row_number() over(partition by Albumid order by Milliseconds) ,Name, Milliseconds  from Track ;




/*
17. Top Tracks per Genre
Objective: For each genre, list the top 3 tracks based on duration
*/


select * from (select Genreid, Trackid,row_number() over(partition by Genreid order by Milliseconds  desc) as lm , Milliseconds  from Track) as ll where lm<=3 ;






