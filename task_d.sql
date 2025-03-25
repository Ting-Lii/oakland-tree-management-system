-- update the existing siteVisits table with recommended tree and photo before planting information
-- and update the tree request status to approved or rejected

-- use stored procedure to update the siteVisits table
DELIMITER //
CREATE PROCEDURE record_site_visit_info(
    IN p_site_visit_id INT,
    IN p_power_line BOOLEAN,
    IN p_bed_width INT,
    IN p_photo_before VARCHAR(255),
    IN p_visit_status BOOLEAN
)
BEGIN
    DECLARE site_visit_exists INT;
    DECLARE tree_req_ref VARCHAR(40);

    SELECT COUNT(*)
    INTO site_visit_exists
    FROM siteVisits
    WHERE siteVisitID = p_site_visit_id;

    IF site_visit_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Site visit not found';
    ELSE
        UPDATE siteVisits
        SET powerLine = p_power_line,
            bedWidth = p_bed_width,
            photoBefore = p_photo_before,
            visitStatus = p_visit_status
        WHERE siteVisitID = p_site_visit_id;

        -- Retrieve the tree request reference associated with this site visit
        SELECT requestRefNum INTO tree_req_ref
        FROM siteVisits
        WHERE siteVisitID = p_site_visit_id;

        IF p_visit_status = TRUE THEN
            REPLACE INTO recommendedTrees (visitID, treeID) -- replace into: if the record exists, it will be replaced
            SELECT p_site_visit_id, t.treeID
            FROM trees t
            WHERE (p_power_line = TRUE AND t.plantableUnderPowerLines = TRUE)
            OR (p_power_line = FALSE)
            AND t.minPlantingBedWidth <= p_bed_width;

            -- Update the corresponding tree request status to approved
            UPDATE treeRequests
            SET requestStatus = 'approved'
            WHERE referenceNum = tree_req_ref;
        ELSE
            UPDATE treeRequests
            SET requestStatus = 'rejected'
            WHERE referenceNum = tree_req_ref;
        END IF;

        SELECT 'Site visit information recorded successfully' AS Result;
    END IF;
END //
DELIMITER ;

-- Record information for a completed site visit
CALL record_site_visit_info(
    1,
    TRUE, -- power line present
    5,
    'https://example.com/photos/site1_before.jpg',
    TRUE -- visit completed
);

-- view the updated site visit information
SELECT sv.*, rt.treeID, t.commonName
FROM siteVisits sv
LEFT JOIN recommendedTrees rt ON sv.siteVisitID = rt.visitID
LEFT JOIN trees t ON rt.treeID = t.treeID
WHERE sv.siteVisitID = 1;
