#set delimiter to //
DELIMITER //
DROP Procedure if exists GetMaxQuantity;
# create a procedure to get the maximum ordered quantity in Orders table
CREATE procedure GetMaxQuantity()
BEGIN
	SELECT MAX(quantity) as `Max Quantity in Order`
	FROM orders;
END //

DROP PROCEDURE IF EXISTS CancelOrder;

# create a stored procedure called CancelOrder.
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
	IF EXISTS (SELECT * FROM orders WHERE orderID=order_id) THEN
		DELETE FROM orders WHERE orderId = order_id;
        SELECT CONCAT("Order ",order_id, " is cancelled") as Confirmation;
	ELSE
		SELECT CONCAT("Order ",order_id, " does not exist.") as Confirmation;
	END IF;
END //
# reset the delimiter to semicolon
DELIMITER ;

# create a prepared statement GetOrderDetail.
PREPARE GetOrderDetail FROM 'SELECT orderID, quantity, bill_amount as cost FROM Orders WHERE orderID = ?';

