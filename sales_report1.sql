# create ordersview
DROP VIEW IF EXISTS ordersview;
CREATE VIEW ordersview AS
SELECT orderID as OrderID, quantity as Quantity, bill_amount as Cost
FROM orders;
#create customer_order_view
DROP VIEW IF EXISTS customer_order_view;
CREATE VIEW customer_order_view AS
SELECT 
	orders.customerID as CustomerID, 
    CONCAT(customers.customerFirstName,' ' ,customers.customerLastName) as FullName, 
    orders.orderID as OrderID, 
    orders.bill_amount as Cost,
    menu.menuName as MenuName,
    menuitem.courseName as CourseName
FROM orders 
INNER JOIN customers ON orders.customerID=customers.customerID
INNER JOIN menu ON orders.menuID=menu.menuID
INNER JOIN menuitem ON menu.itemID=menuitem.menuItemID
WHERE bill_amount>150;

#find menu items for which more than 2 orders have been placed.
select menuName as MenuName
from menu
where menuID = ANY (
	SELECT menuID from orders where quantity >2
);