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
