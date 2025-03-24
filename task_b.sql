-- Accept a request for a tree, registering as a new user if necessary.
-- When requesting a tree, users will need to specify their address

-- First, check if user exists by email
SET @user_email = 'sarasmith@email.com';
SET @existing_user_id =
    (SELECT uid
    FROM users
    WHERE email = @user_email);

-- If user doesn't exist, create new user
IF @existing_user_id IS NULL THEN
    INSERT INTO users (firstName, lastName, email, password, zipCode, role, neighborhood)
    VALUES (
        'Sarah',
        'Smith',
        @user_email,
        'securepass789',
        '94611',
        'resident',
        'Clawson'
    );
    SET @existing_user_id = LAST_INSERT_ID();
END IF;

-- Generate a unique reference number for the tree request
SET @ref_num = UUID();

-- Create the tree request
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
           @existing_user_id,
           '123 Oak Street',
           '94611',
           '(510)555-0123',
           0.00,
           'owner',
           CURRENT_DATE,
           'submitted',
           'Clawson'
       );

-- Return the reference number for the request
SELECT @ref_num AS 'Tree Request Reference Number';
