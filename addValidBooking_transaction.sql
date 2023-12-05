DROP PROCEDURE if EXISTS AddValidBooking ;
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN addDate DATE, IN table_no INT, IN staff_id INT, IN booking_slot TIME)
BEGIN
	IF EXISTS (SELECT * FROM bookings WHERE bookingDate = addDate AND bookingslot=booking_slot AND tableNo = table_no) THEN
		SELECT CONCAT("Table " , table_no, " is already booked at ", addDate, " ", booking_slot, " - booking cancelled") as 'Booking status';
	ELSE
		INSERT INTO bookings (bookingDate, tableNo, staffID, bookingslot) values
		(addDate, table_no, staff_id, booking_slot);
        SELECT CONCAT("Booking confirmed. Table " , table_no, " is booked successfully at ", addDate, " ", booking_slot) as 'Booking status';
	END IF;
END //
DELIMITER ;

START TRANSACTION;
call AddValidBooking('2022-12-17', 6, 1, '16:00:00');
rollback;





