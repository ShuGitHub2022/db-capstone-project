DELIMITER //

DROP PROCEDURE IF EXISTS UpdateBooking;
# UpdateBooking procedure takes two parameters booking id and booking date.
CREATE PROCEDURE UpdateBooking(
    IN booking_id INT, 
    IN booking_date DATE
)
BEGIN
    IF NOT EXISTS (
        SELECT * FROM bookings WHERE bookingID = booking_id
    ) THEN
        SELECT CONCAT("Booking ", booking_id, " does not exist.") AS 'ERROR';
    ELSE
        UPDATE bookings set bookingDate = booking_date WHERE bookingID = booking_id;
        SELECT CONCAT("Booking ",booking_id, " updated.") AS 'Confirmation';
    END IF;
END //

DELIMITER ;
call updateBooking(7,'2022-11-13');