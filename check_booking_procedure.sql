# drop procedure CheckBooking if exits.
drop procedure if exists CheckBooking;
DELIMITER //
CREATE PROCEDURE CheckBooking(IN checkDate Date, IN table_no INT)
BEGIN
	IF EXISTS (SELECT * FROM bookings WHERE bookingDate = checkDate AND tableNo = table_no) THEN
		SELECT CONCAT("Table ", table_no, " is already booked") AS 'Booking Status';
	ELSE
		SELECT CONCAT("Table ", table_no, " is not booked yet.") AS 'Booking Status';
	END IF;
END //

DELiMITER ;

call CheckBooking('2022-11-12',3);