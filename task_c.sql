-- 1. Validate the tree request exists and is in a valid status
-- 2. Create a site visit record and update the tree request status to pending
-- 3. if site visit already exists, update the site visit date and administrator ID

-- use a stored procedure to schedule a site visit
DELIMITER //
CREATE PROCEDURE schedule_site_visit(
    IN p_request_ref_num VARCHAR(40),
    IN p_admin_id INT,
    IN p_visit_date DATE
)
BEGIN
    DECLARE request_exists INT;
    DECLARE request_status VARCHAR(20);
    DECLARE request_address VARCHAR(60);
    DECLARE visit_exists INT;

    -- Check if tree request exists and get its status
    SELECT COUNT(*), MAX(requestStatus), MAX(streetAddress) -- If COUNT(*) > 0, the request exists, Count(*) = 0, no matching request; MAX(): get a single value for a unique request
    INTO request_exists, request_status, request_address
    FROM treeRequests
    WHERE referenceNum = p_request_ref_num;

    IF request_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tree request not found';
    END IF;

    -- Validate tree request status
    IF request_status NOT IN ('submitted', 'pending') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Request is not in a valid status for site visit';
    END IF;

    -- Check if site visit exists
    SELECT COUNT(*)
    INTO visit_exists
    FROM siteVisits
    WHERE requestRefNum = p_request_ref_num;

    -- If no site visit exists, create a new record; otherwise, update the existing record
    IF visit_exists = 0 THEN
        INSERT INTO siteVisits (
            siteVisitDate,
            visitStatus,
            streetAddress,
            requestRefNum,
            aid
        )
        VALUES (
                p_visit_date,
                FALSE,
                request_address,
                p_request_ref_num,
                p_admin_id
               );
        -- Update tree request status to pending
        UPDATE treeRequests
        SET requestStatus = 'pending'
        WHERE referenceNum = p_request_ref_num;
        SELECT 'Site visit scheduled successfully' AS Result;
    ELSE
         -- update existing site visit record
        UPDATE siteVisits
        SET siteVisitDate = p_visit_date, aid = p_admin_id
        WHERE requestRefNum = p_request_ref_num;
    END IF;
END //
DELIMITER ;

-- Schedule a visit to a site requesting a tree (test to use first row in siteVisit table)
CALL schedule_site_visit(
    '1fef06e1-a710-4e05-b921-b84e40c41ea2',
    1,
    '2024-04-01'
);


