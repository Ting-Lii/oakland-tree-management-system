-- 1. Validate the tree request exists and is approved
-- 2. Create a tree planting record
-- 3. Assign available volunteers to the planting based on their availabilities and set to false after scheduling

-- use stored procedure to schedule a tree planting event
DELIMITER //
CREATE PROCEDURE schedule_tree_planting(
    IN p_request_ref_num VARCHAR(40),
    IN p_event_name VARCHAR(60),
    IN p_plant_date DATE,
    IN p_admin_id INT,
    IN p_tree_name VARCHAR(200),
    IN p_volunteer_ids VARCHAR(255) -- Comma-separated list of volunteer IDs
)
BEGIN
    DECLARE request_exists INT;
    DECLARE request_status VARCHAR(20);
    DECLARE request_address VARCHAR(60);
    DECLARE request_zip VARCHAR(10);
    DECLARE min_volunteers INT DEFAULT 3; -- Minimum required volunteers
    DECLARE volunteer_count INT;
    DECLARE new_planting_id INT;

    -- Check if tree request exists and get its details
    SELECT COUNT(*)
    INTO request_exists, request_status, request_address, request_zip
    FROM treeRequests
    WHERE referenceNum = p_request_ref_num;

    -- Retrieve tree request details
    SELECT requestStatus, streetAddress, zipCode
    INTO request_status, request_address, request_zip
    FROM treeRequests
    WHERE referenceNum = p_request_ref_num
    LIMIT 1; -- using LIMIT 1 to ensure only one row is returned

    -- Count number of volunteers provided
    SET volunteer_count = (LENGTH(p_volunteer_ids) - LENGTH(REPLACE(p_volunteer_ids, ',', '')) + 1); -- Count commas + 1

    -- Validate tree request and volunteers
    IF request_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tree request not found';
    ELSEIF request_status != 'approved' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tree request must be approved before scheduling planting';
    ELSEIF volunteer_count < min_volunteers THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient number of volunteers';
    ELSE
        -- Create tree planting record
        INSERT INTO treePlantings (
            requestRefNum,
            eventName,
            plantDate,
            streetAddress,
            zipCode,
            treePlanted,
            aid
        )
        VALUES (
            p_request_ref_num,
            p_event_name,
            p_plant_date,
            request_address,
            request_zip,
            p_tree_name,
            p_admin_id
        );

        SET new_planting_id = LAST_INSERT_ID();

        -- Assign available volunteers (minimum 3)
        -- initial workHour = 0, feedback = NULL by default
        INSERT INTO volunteerPlants (plantID, vid, workHour, feedback)
        SELECT new_planting_id, v.vid,0.0, NULL
        FROM volunteers v
        WHERE v.availability = TRUE
        LIMIT 3; -- Minimum required volunteers

        -- Update assigned volunteers' availability to False to prevent double-booking
        UPDATE volunteers
        SET availability = FALSE
        WHERE vid IN (
            SELECT vid
            FROM volunteerPlants
            WHERE plantID = new_planting_id
        );

        SELECT 'Tree planting scheduled successfully' AS Result;
    END IF;
END //
DELIMITER ;

-- Schedule a tree planting with multiple volunteers
CALL schedule_tree_planting(
    'a6fd6eca-9e70-4fa8-ae8c-374032c6dd78',
    'Community Tree Planting Day',
    '2024-04-15',
    1,
    'Cedrus atlantica',
    '51,52,53,54' -- List of volunteer IDs
);

-- View the scheduled planting and assigned volunteers
SELECT tp.*, vp.vid as volunteer_id
FROM treePlantings tp
LEFT JOIN volunteerPlants vp ON tp.plantID = vp.plantID
WHERE tp.requestRefNum = 'a6fd6eca-9e70-4fa8-ae8c-374032c6dd78';
