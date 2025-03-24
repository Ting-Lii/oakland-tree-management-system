-- Register a new user (volunteers or residents requesting a tree)
-- volunteer registration: 1. insert into users table first(since volunteers must be users)
-- 2. Insert into volunteers table using the new user's ID

INSERT INTO users (firstName, lastName, email, password, zipCode, neighborhood)
VALUES ('John', 'Doe', 'john.doe@email.com', 'securepass123', '94143', 'Rockridge');
SET @new_user_id = LAST_INSERT_ID(); -- Get the ID of the newly inserted user
INSERT INTO volunteers (vid, applicationStatus, availability)
VALUES (@new_user_id, 'submitted', true);

-- resident registration: just insert into users table
INSERT INTO users (firstName, lastName, email, password, zipCode, neighborhood)
VALUES ('Jane', 'Doe', 'jane.doe@email.com', 'securepass345', '94140', 'Temescal');
