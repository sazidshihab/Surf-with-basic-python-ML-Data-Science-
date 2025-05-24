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







