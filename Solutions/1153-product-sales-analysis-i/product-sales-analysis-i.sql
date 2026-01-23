-- This query selects the product name, year, and price from the Sales table
-- It performs a LEFT JOIN with the Product table to include all sales records,
-- even if there is no matching product in the Product table.
select p.product_name, s.year, s.price 
from Sales s 
left join Product p
    on s.product_id = p.product_id;
