-- get current tree inventory
-- check valid removal of tree to prevent negative inventory
-- update tree inventory
-- Trigger to automatically reduce inventory when a tree is planted

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


-- trigger to handle tree planting deletion
CREATE TRIGGER after_tree_planting_delete
    AFTER DELETE ON treePlantings
    FOR EACH ROW
BEGIN
    -- Increase inventory by 1 when a tree planting record is deleted
    UPDATE trees
    SET inventory = inventory + 1
    WHERE commonName = OLD.treePlanted;
END //

DELIMITER ;

-- Example usage:
-- Add 5 trees to inventory of a specific species
CALL update_tree_inventory('African fern pine', 5, @new_quantity);
SELECT @new_quantity as 'New Inventory Level';

-- Remove 2 trees from inventory of a specific species
CALL update_tree_inventory('African fern pine', -2, @new_quantity);
SELECT @new_quantity as 'New Inventory Level';

-- Query to view current inventory levels
SELECT commonName, inventory
FROM trees
ORDER BY commonName;
