-- Creating a stored procedure to update planting records
-- Recording volunteer participation and feedback
-- Adding admin observations via photos

DELIMITER //
CREATE PROCEDURE record_planting_completion(
    IN p_plant_id INT,
    IN p_photo_after VARCHAR(200),
    IN p_vid INT,
    IN p_work_hour FLOAT,
    IN p_feedback VARCHAR(20)
)
BEGIN
    -- Validate planting exists
    IF NOT EXISTS (SELECT 1 FROM treePlantings WHERE plantID = p_plant_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Planting ID does not exist';
    END IF;

    -- Update planting record with photo
    UPDATE treePlantings
    SET photoAfter = p_photo_after
    WHERE plantID = p_plant_id;

    -- Update volunteer's work hours and feedback
    UPDATE volunteerPlants
    SET workHour = p_work_hour,
        feedback = p_feedback
    WHERE plantID = p_plant_id AND vid = p_vid;

    -- Reset volunteer's availability
    UPDATE volunteers
    SET availability = TRUE
    WHERE vid = p_vid;

    -- Return updated record
    SELECT tp.*, vp.vid, vp.workHour, vp.feedback
    FROM treePlantings tp
             JOIN volunteerPlants vp ON tp.plantID = vp.plantID
    WHERE tp.plantID = p_plant_id AND vp.vid = p_vid;
END //
DELIMITER ;

-- Call the procedure for each volunteer
CALL record_planting_completion(
        1,
        'https://example.com/photos/after_planting1.jpg',
        51,
        2.5,
        'moderate'
     );
CALL record_planting_completion(
        1,
        'https://example.com/photos/after_planting1.jpg',
        52,
        3.0,
        'heavy'
     );
CALL record_planting_completion(
        1,
        'https://example.com/photos/after_planting1.jpg',
        53,
        2.0,
        'moderate'
     );

-- View the planting completion records
SELECT
    tp.plantID,
    tp.eventName,
    tp.plantDate,
    tp.photoAfter,
    vp.vid AS volunteer_id,
    vp.workHour,
    vp.feedback
FROM treePlantings tp
         JOIN volunteerPlants vp ON tp.plantID = vp.plantID
ORDER BY tp.plantID, vp.vid;
