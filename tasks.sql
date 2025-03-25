-- task a
  -- Register a new user (volunteers or residents requesting a tree)

  -- First create a stored procedure to handle user registration with validation
  DELIMITER //
  CREATE PROCEDURE register_user(
      IN p_firstName VARCHAR(40),
      IN p_lastName VARCHAR(40),
      IN p_email VARCHAR(40),
      IN p_password VARCHAR(40),
      IN p_zipCode VARCHAR(10),
      IN p_role VARCHAR(20),
      IN p_neighborhood VARCHAR(60),
      IN p_is_volunteer BOOLEAN,
      OUT p_user_id INT
  )
  BEGIN
      DECLARE neighborhood_exists INT;
      DECLARE email_valid INT;

  -- Check if neighborhood exists
  SELECT COUNT(*) INTO neighborhood_exists
  FROM neighborhoods
  WHERE name = p_neighborhood;

  -- Check if email is valid (contains @ and at least one . after @)
  SET email_valid = p_email LIKE '%@%._%';

      -- Validate inputs
      IF neighborhood_exists = 0 THEN
          SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Invalid neighborhood';
      ELSEIF email_valid = 0 THEN
          SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Invalid email format';
  ELSE
          -- Insert user: (user can be volunteer, admin or resident)
          INSERT INTO users (firstName, lastName, email, password, zipCode, role, neighborhood)
          VALUES (p_firstName, p_lastName, p_email, p_password, p_zipCode, p_role,p_neighborhood);

          SET p_user_id = LAST_INSERT_ID();

          -- If registering as volunteer, add to volunteers table
          -- volunteer: 1. insert into users table first(since volunteers must be users) 2.Insert into volunteers table using the new user's ID
          IF p_is_volunteer THEN
              INSERT INTO volunteers (vid, applicationStatus, availability)
              VALUES (p_user_id, 'submitted', true);
  END IF;
  END IF;
  END //
  DELIMITER ;

  -- volunteer registration:
  CALL register_user(
      'John',
      'Doe',
      'john.doe@email.com',
      'securepass123',
      '94143',
      'volunteer',
      'Rockridge',
      true,
      @new_user_id
  );

  -- resident registration:
  CALL register_user(
      'Jane',
      'Doe',
      'jane.doe@email.com',
      'securepass345',
      '94140',
      'resident',
      'Temescal',
      false,
      @new_user_id
  );

-- task b
    -- Accept a request for a tree, registering as a new user if necessary using stored procedure from task a
    -- Create the tree request using the parameterized values

    -- stored procedure to process a tree request
    DELIMITER //
    CREATE PROCEDURE process_tree_request(
        IN p_user_email VARCHAR(40),
        IN p_firstName VARCHAR(40),
        IN p_lastName VARCHAR(40),
        IN p_password VARCHAR(40),
        IN p_zipCode VARCHAR(10),
        IN p_role VARCHAR(20),
        IN p_neighborhood VARCHAR(60),
        IN p_streetAddress VARCHAR(100),
        IN p_requestZip VARCHAR(10),
        IN p_phone VARCHAR(20),
        IN p_amount DECIMAL(10,2),
        IN p_relationship VARCHAR(20),
        IN p_requestStatus VARCHAR(20)
    )
    BEGIN
        DECLARE existing_user_id INT;
        DECLARE new_user_id INT;

    -- First, check if user exists by email
        SELECT uid INTO existing_user_id
        FROM users
        WHERE email = p_user_email;

        -- If user doesn't exist, use stored procedure register_user from task a
        IF existing_user_id IS NULL THEN
            CALL register_user(
                    p_firstName,
                    p_lastName,
                    p_user_email,
                    p_password,
                    p_zipCode,
                    p_role,
                    p_neighborhood,
                    false, -- not a volunteer
                    new_user_id
                );
                SET existing_user_id = new_user_id;
        END IF;

        -- Generate a unique reference number for the tree request
        SET @ref_num = UUID();

        -- Create the tree request using parameterized values
        INSERT INTO treeRequests (
            referenceNum,
            rid,
            streetAddress,
            zipCode,
            phone,
            amountOfPayment,
            relationshipToProperty,
            dateSubmitted,
            requestStatus,
            neighborhood
        )
        VALUES (
                @ref_num,
                existing_user_id,
                p_streetAddress,
                p_requestZip,
                p_phone,
                p_amount,
                p_relationship,
                CURRENT_DATE,
                p_requestStatus,
                p_neighborhood);

        -- Return the reference number for the request
        SELECT @ref_num AS 'Tree Request Reference Number';
    END //
    DELIMITER ;

-- task c
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

-- task d
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

-- task e
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
        SELECT COUNT(*) as request_count,
            MAX(requestStatus) as request_status, -- Since filtering by a unique reference number, using MAX won't affect the actual values
            MAX(streetAddress) as street_address,
            MAX(zipCode) as zip_code
        INTO request_exists, request_status, request_address, request_zip
        FROM treeRequests
        WHERE referenceNum = p_request_ref_num;

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

-- task f
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
      IF NOT EXISTS
          (SELECT 1
          FROM treePlantings
          WHERE plantID = p_plant_id) THEN
          SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Planting ID does not exist';
      END IF;

      -- Update planting record with photo
      UPDATE treePlantings
      SET photoAfter = p_photo_after
      WHERE plantID = p_plant_id;

      -- Update volunteer's work hours and feedback
      UPDATE volunteerPlants
      SET workHour = p_work_hour, feedback = p_feedback
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

-- task g
  -- get current tree inventory
  -- check valid removal of tree to prevent negative inventory
  -- update tree inventory
  -- Trigger to automatically reduce inventory when a tree is planted
  -- add tree inventory by checking if tree species exists first, then update the number of inventory for existing species, or add new species


  DELIMITER //
  CREATE PROCEDURE update_tree_inventory(
      IN p_tree_common_name VARCHAR(50),
      IN p_quantity_change INT, -- Positive for additions, negative for removals
      OUT p_new_quantity INT
  )
  BEGIN
      DECLARE current_quantity INT;

      -- Get current inventory
      SELECT inventory INTO current_quantity
      FROM trees
      WHERE commonName = p_tree_common_name;

      IF current_quantity IS NULL THEN
          SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Tree species not found';
      END IF;

      -- Check if removal would result in negative inventory
      IF (current_quantity + p_quantity_change) < 0 THEN
          SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Insufficient inventory for removal';
      END IF;

      -- Update inventory
      UPDATE trees
      SET inventory = inventory + p_quantity_change
      WHERE commonName = p_tree_common_name;

      -- Get new quantity
      SELECT inventory INTO p_new_quantity
      FROM trees
      WHERE commonName = p_tree_common_name;
  END //

  -- after tree planting trigger
  CREATE TRIGGER after_tree_planting
      AFTER INSERT ON treePlantings -- fires after insert on the treePlantings table
      FOR EACH ROW -- executes for each row that gets inserted
  BEGIN
      -- Reduce inventory by 1 when a tree is planted
      UPDATE trees
      SET inventory = inventory - 1
      WHERE commonName = NEW.treePlanted AND inventory > 0;

      -- Raise an error if inventory becomes negative
      IF (SELECT inventory
          FROM trees
          WHERE commonName = NEW.treePlanted) < 0 THEN
          SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Tree planting failed: Insufficient inventory';
      END IF;
  END //

  -- Add tree inventory or insert new tree species
  CREATE PROCEDURE add_tree_inventory(
      IN p_common_name VARCHAR(50),
      IN p_scientific_name VARCHAR(100),
      IN p_quantity INT
  )
  BEGIN
      -- Check if tree exists
      IF EXISTS (SELECT 1 FROM trees WHERE commonName = p_common_name) THEN
          -- Update existing tree inventory
          UPDATE trees
          SET inventory = inventory + 1
          WHERE commonName = p_common_name;
      ELSEIF p_quantity < 0 THEN
          SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Initial inventory cannot be negative';
      ELSE
          -- Insert new tree species: only insert required default values
          INSERT INTO trees (commonName, scientificName, inventory)
          VALUES (p_common_name, p_scientific_name, p_quantity);
      END IF;
  END //
  DELIMITER ;

  -- add an existing tree species to inventory
  CALL add_tree_inventory('African fern pine', 'Afrocarpus gracilior', 1);

  -- Remove a tree from inventory using after_tree_planting trigger
  -- This will automatically reduce the inventory by 1.
  INSERT INTO treePlantings (requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid)
  VALUES (
            'eddfae71-0431-4621-be29-a198b500211b',
            'Spring Planting Event 2024',
            '2024-03-20',
            '222 Oak Street',
            '94611',
            NULL,
            'African fern pine',
            1);

-- task h
  SELECT
      tr.referenceNum,
      tr.streetAddress,
      tr.requestStatus,
      tr.dateSubmitted,
      DATEDIFF(CURRENT_DATE, tr.dateSubmitted) as days_since_submission
  FROM treeRequests tr
  LEFT JOIN treePlantings tp ON tr.referenceNum = tp.requestRefNum
  WHERE tp.plantID IS NULL
  AND tr.requestStatus NOT IN ('rejected')
  ORDER BY tr.dateSubmitted ASC;

-- task i
  SELECT tp.plantDate, tp.streetAddress, tp.zipCode, tr.neighborhood, tp.treePlanted
  FROM treePlantings tp
  JOIN treeRequests tr ON tp.requestRefNum = tr.referenceNum
  WHERE tr.neighborhood IN ('Acron', 'Santa Fe', 'Oak Center', 'Bushrod')
    OR tp.zipCode IN ('93065', '59359')
  ORDER BY tp.plantDate;

-- task j
  -- For every species of trees, find the number of trees planted and:
  -- the number of years since the first tree of the species was planted, the number of years since the most recent tree of the species was planted.
  SELECT
      treePlanted AS species,
      COUNT(*) AS amount,
      EXTRACT(YEAR FROM CURRENT_DATE) - MIN(EXTRACT(YEAR FROM plantDate)) AS years_since_first_planting,
      EXTRACT(YEAR FROM CURRENT_DATE) - MAX(EXTRACT(YEAR FROM plantDate)) AS years_since_last_planting
  FROM treePlantings
  GROUP BY species
  ORDER BY amount DESC, species;

  -- the year that had the most trees of the species planted and the number of trees planted.
  SELECT t.treePlanted AS species, COUNT(*) AS total_planted,
      (
          SELECT EXTRACT(YEAR FROM plantDate)
          FROM treePlantings t_sub
          WHERE t_sub.treePlanted = t.treePlanted
          GROUP BY EXTRACT(YEAR FROM plantDate)
          ORDER BY COUNT(*) DESC
          LIMIT 1
      ) AS year_with_most,
      (
          SELECT COUNT(*)
          FROM treePlantings t_sub2
          WHERE t_sub2.treePlanted = t.treePlanted
          GROUP BY EXTRACT(YEAR FROM plantDate) -- aggregates all rows that occurred within the same year
          ORDER BY COUNT(*) DESC
          LIMIT 1
      ) AS num_planted_in_year
  FROM treePlantings t
  GROUP BY t.treePlanted;

-- task k
  -- For each Oakland neighborhood, create a report that summarizes the requests, their progress (pending, in-process, completed, ec), the trees planted, etc.
  SELECT
      tr.neighborhood,
      COUNT(tr.referenceNum) AS total_requests,
      SUM(CASE WHEN tr.requestStatus = 'submitted' THEN 1 ELSE 0 END) AS submitted,
      SUM(CASE WHEN tr.requestStatus = 'approved' THEN 1 ELSE 0 END) AS approved,
      SUM(CASE WHEN tr.requestStatus = 'pending' THEN 1 ELSE 0 END) AS pending,
      COUNT(tp.plantID) AS trees_planted
  FROM treeRequests tr
  LEFT JOIN treePlantings tp ON tr.referenceNum = tp.requestRefNum
  GROUP BY tr.neighborhood;