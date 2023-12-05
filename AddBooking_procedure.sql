DELIMITER //

DROP PROCEDURE IF EXISTS AddBooking;

CREATE PROCEDURE AddBooking(
    IN booking_id INT, 
    IN customer_id INT, 
    IN booking_date DATE, 
    IN table_no INT, 
    IN staff_id INT, 
    IN booking_slot TIME
)
BEGIN
    IF EXISTS (
        SELECT * FROM bookings WHERE bookingDate = booking_date 
        AND bookingslot = booking_slot 
        AND tableNo = table_no
    ) THEN
        SELECT CONCAT(table_no, " is already booked at ", booking_date, " ", booking_slot, " - booking cancelled") AS 'ERROR';
    ELSE
        INSERT INTO bookings (bookingID, bookingDate, tableNo, customerID, staffID, bookingslot) 
        VALUES (booking_id, booking_date, table_no, customer_id, staff_id, booking_slot);
        SELECT "New booking added" AS 'Confirmation';
    END IF;
END //

DELIMITER ;