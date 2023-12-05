DELIMITER //

DROP PROCEDURE IF EXISTS CancelBooking;

# CancelBooking procedure takes 1 parameters booking id.
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
    IF NOT EXISTS (
        SELECT * FROM bookings WHERE bookingID = booking_id
    ) THEN
        SELECT CONCAT("Booking ", booking_id, " does not exist.") AS 'ERROR';
    ELSE
        DELETE FROM bookings WHERE bookingID = booking_id;
        SELECT CONCAT("Booking ",booking_id, " cancelled.") AS 'Confirmation';
    END IF;
END //

DELIMITER ;