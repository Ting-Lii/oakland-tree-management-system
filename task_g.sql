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


