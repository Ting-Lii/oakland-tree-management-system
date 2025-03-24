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
SET email_valid = p_email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';

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
