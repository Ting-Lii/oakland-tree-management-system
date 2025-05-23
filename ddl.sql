CREATE TABLE neighborhoods(
    name VARCHAR(60) NOT NULL,
    district VARCHAR(60),
    description VARCHAR(600),
    CONSTRAINT PK_neighborhood_name PRIMARY KEY (name)
);

-- lookup table for the user role
CREATE TABLE userRoles(
    roleName VARCHAR(20) NOT NULL,
    CONSTRAINT PK_user_role PRIMARY KEY (roleName)
);

CREATE TABLE users(
    uid INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(40),
    lastName VARCHAR(40),
    email VARCHAR(40) NOT NULL,
    password VARCHAR(40),
    zipCode VARCHAR(10),
    role VARCHAR(20),
    neighborhood VARCHAR(60) DEFAULT NULL,
    CONSTRAINT PK_uid PRIMARY KEY (uid),
    CONSTRAINT CK_user_email UNIQUE (email),
    CONSTRAINT FK_user_role FOREIGN KEY (role)
        REFERENCES userRoles(roleName) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_neighborhood_name FOREIGN KEY (neighborhood)
        REFERENCES neighborhoods(name) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT Check_isvalid_email
        CHECK (email LIKE '%_@_%._%')
);

-- lookup table for the request status
CREATE TABLE requestApplyStatuses(
    requestStatus VARCHAR(20) NOT NULL,
    CONSTRAINT PK_request_status PRIMARY KEY (requestStatus)
);

CREATE TABLE volunteers(
    vid INT NOT NULL,
    applicationStatus VARCHAR(20),
    isAvailable BOOLEAN,
    CONSTRAINT PK_vid PRIMARY KEY (vid),
    CONSTRAINT FK_volunteer_uid FOREIGN KEY (vid)
        REFERENCES users(uid) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_volunteer_status FOREIGN KEY (applicationStatus)
        REFERENCES requestApplyStatuses(requestStatus) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE permits(
    permitID VARCHAR(40) NOT NULL,
    rid INT NOT NULL,
    permitStatus VARCHAR(20) NOT NULL,
    issueDate DATE,
    CONSTRAINT PK_permitID PRIMARY KEY (permitID),
    CONSTRAINT FK_permit_uid FOREIGN KEY (rid)
        REFERENCES users(uid) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_permit_status FOREIGN KEY (permitStatus)
        REFERENCES requestApplyStatuses(requestStatus) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE treeRequests(
    requestID INT NOT NULL AUTO_INCREMENT,
    rid INT NOT NULL,
    streetAddress VARCHAR(60) NOT NULL,
    dateSubmitted DATE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    amountOfPayment FLOAT DEFAULT 0.0 NOT NULL,
    relationshipToProperty VARCHAR(20),
    reqZipCode VARCHAR(10) NOT NULL,
    requestStatus VARCHAR(20) NOT NULL,
    neighborhood VARCHAR(60),
    CONSTRAINT PK_request_ID PRIMARY KEY (requestID),
    CONSTRAINT FK_tree_request_uid FOREIGN KEY (rid)
        REFERENCES users(uid) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_request_status FOREIGN KEY (requestStatus)
        REFERENCES requestApplyStatuses(requestStatus) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_request_neighborhood FOREIGN KEY (neighborhood)
        REFERENCES neighborhoods(name) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT CK_tree_request UNIQUE(streetAddress, dateSubmitted, phone),
    CONSTRAINT check_isvalid_payment
        CHECK ( amountOfPayment >= 0.0 )
);

-- drought tolerance lookup table
CREATE TABLE droughtTolerances(
    droughtTolerance VARCHAR(40) PRIMARY KEY
);

-- growth rate lookup table
CREATE TABLE growthRates(
    growthRate VARCHAR(40) PRIMARY KEY
);

-- foliage type lookup table
CREATE TABLE foliageTypes(
    foliageType VARCHAR(40) PRIMARY KEY
);

-- root damage potential lookup table
CREATE TABLE rootDamagePotentials(
    rootDamagePotential VARCHAR(40) PRIMARY KEY
);

-- nursery availability lookup table
CREATE TABLE nurseryAvailabilities(
    nurseryAvailability VARCHAR(40) PRIMARY KEY
);

-- treeSpecies table.
CREATE TABLE treeSpecies(
   treeID INT AUTO_INCREMENT, -- PK and SK
   commonName VARCHAR(50) NOT NULL,
   scientificName VARCHAR(50) NOT NULL,
   minHeight INT NOT NULL,
   maxHeight INT NOT NULL,
   minWidth INT NOT NULL,
   maxWidth INT NOT NULL,
   minPlantingBedWidth INT,
   isPlantableUnderPowerLines BOOLEAN,
   isCaNative BOOLEAN,
   droughtTolerance VARCHAR(40),
   growthRate VARCHAR(40),
   foliageType VARCHAR(40),
   debris VARCHAR(100),
   rootDamagePotential VARCHAR(40),
   nurseryAvailability VARCHAR(40),
   visualAttraction VARCHAR(50),
   inventory INT DEFAULT 0 NOT NULL,
   CONSTRAINT PK_trees_id PRIMARY KEY(treeID),
   CONSTRAINT FK_drought_tolerance FOREIGN KEY(droughtTolerance)
        REFERENCES droughtTolerances(droughtTolerance) ON DELETE SET NULL ON UPDATE CASCADE,
   CONSTRAINT FK_growth_rate FOREIGN KEY(growthRate)
        REFERENCES growthRates(growthRate) ON DELETE SET NULL ON UPDATE CASCADE,
   CONSTRAINT FK_foliage_type FOREIGN KEY(foliageType)
        REFERENCES foliageTypes(foliageType) ON DELETE SET NULL ON UPDATE CASCADE,
   CONSTRAINT FK_root_damage_potential FOREIGN KEY(rootDamagePotential)
        REFERENCES rootDamagePotentials(rootDamagePotential) ON DELETE SET NULL ON UPDATE CASCADE,
   CONSTRAINT FK_nursery_availability FOREIGN KEY(nurseryAvailability)
        REFERENCES nurseryAvailabilities(nurseryAvailability) ON DELETE SET NULL ON UPDATE CASCADE,
   CONSTRAINT CK_tree_common_name UNIQUE(commonName),
   CONSTRAINT CK_tree_scientific_name UNIQUE(scientificName)
);

CREATE TABLE treePlantings(
    requestID INT NOT NULL,
    plantDate DATE,
    photoAfter VARCHAR(200),
    aid INT NOT NULL,
    treePlanted INT NOT NULL,
    CONSTRAINT PK_planting_request_id PRIMARY KEY (requestID),
    CONSTRAINT FK_planting_request_id FOREIGN KEY (requestID)
        REFERENCES treeRequests(requestID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_planting_aid FOREIGN KEY (aid)
        REFERENCES users(uid) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_planting_tree_id FOREIGN KEY(treePlanted)
        REFERENCES treeSpecies(treeID) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- lookup table for the workload feedback
CREATE TABLE workloadFeedbacks(
    workloadFeedback VARCHAR(20) NOT NULL,
    CONSTRAINT PK_workload_feedback PRIMARY KEY (workloadFeedback)
);

CREATE TABLE volunteerPlants(
    requestID INT NOT NULL,
    vid INT NOT NULL,
    workHour FLOAT NOT NULL,
    workloadFeedback VARCHAR(20),
    CONSTRAINT PK_volunteer_plants PRIMARY KEY (requestID, vid),
    CONSTRAINT FK_volunteer_plants_requestID FOREIGN KEY (requestID)
        REFERENCES treePlantings(requestID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_volunteer_plant_vid FOREIGN KEY (vid)
        REFERENCES volunteers(vid) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_volunteer_workload_feedback FOREIGN KEY (workloadFeedback)
        REFERENCES workloadFeedbacks(workloadFeedback) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE plantingZoneFactors(
   factor VARCHAR(60) NOT NULL,
   CONSTRAINT PK_planting_zone_factor PRIMARY KEY (factor)
);

-- visitStatus lookup table
CREATE TABLE visitStatuses(
    visitStatus VARCHAR(20) NOT NULL PRIMARY KEY
);

-- siteVisits table
CREATE TABLE siteVisits(
    requestID INT NOT NULL,
    aid INT NOT NULL,
    siteVisitDate DATE NOT NULL,
    visitStatus VARCHAR(20) NOT NULL,
    isUnderPowerLine BOOLEAN,
    minBedWidth INT,                                  -- min bedWidth here
    photoBefore VARCHAR(255),                      -- Photo before planting
    CONSTRAINT PK_site_visit_request_id PRIMARY KEY (requestID),
    CONSTRAINT FK_site_visit_request_id FOREIGN KEY (requestID)
        REFERENCES treeRequests(requestID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_site_visti_aid FOREIGN KEY (aid)
        REFERENCES users(uid) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_site_visit_status FOREIGN KEY (visitStatus)
        REFERENCES visitStatuses(visitStatus) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- tree and its corresponding planting zone factors
CREATE TABLE treeToPlantingZones(
    plantingZoneFactor VARCHAR(60) NOT NULL,
    treeID INT NOT NULL,
    CONSTRAINT PK_tree_to_planting_zone PRIMARY KEY(treeID, plantingZoneFactor),
    CONSTRAINT FK_tree_id FOREIGN KEY (treeID) 
        REFERENCES treeSpecies(treeID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_planting_zone_factor FOREIGN KEY (plantingZoneFactor)
        REFERENCES plantingZoneFactors(factor) ON DELETE CASCADE ON UPDATE CASCADE
);

-- recommendedTrees table
CREATE TABLE recommendedTrees(
    requestID INT NOT NULL,
    treeID INT NOT NULL,
    CONSTRAINT PK_recommended_trees PRIMARY KEY (requestID, treeID),
    CONSTRAINT FK_recommended_trees_visit_id FOREIGN KEY (requestID) 
        REFERENCES siteVisits(requestID) ON DELETE CASCADE ON UPDATE CASCADE, 
        -- if a siteVisit is deleted, delete recommendedTrees rows
        -- if siteVisitID is updated, update it automatically
    CONSTRAINT FK_recommended_trees_tree_id FOREIGN KEY (treeID) 
        REFERENCES treeSpecies(treeID) ON DELETE CASCADE ON UPDATE CASCADE 
        -- if treeID is updated, update row automatically
        -- if a tree is deleted, delete recommendedTrees rows
);

DROP PROCEDURE IF EXISTS delete_a_treeRequest;
DELIMITER //

CREATE PROCEDURE delete_a_treeRequest(
    IN treeRequestID INT,  -- id of the tree request
    OUT status VARCHAR(500) -- message providing status of request
)
BEGIN
    DECLARE row_count INT DEFAULT 0;
    DECLARE siteVisits_deleted_count INT DEFAULT 0;
    DECLARE treePlantings_deleted_count INT DEFAULT 0;
    DECLARE recommendedTrees_deleted_count INT DEFAULT 0;
    DECLARE volunteerPlants_deleted_count INT DEFAULT 0;

    -- verify if the tree request exists
    SELECT COUNT(requestID) INTO row_count
        FROM treeRequests WHERE requestID = treeRequestID;

    SET status = '';

    IF row_count = 1 THEN -- this tree request exists
        SELECT COUNT(requestID) INTO row_count
            FROM siteVisits WHERE requestID = treeRequestID;

        IF row_count = 1 THEN -- the related site visit exists, delete it
            SET siteVisits_deleted_count = 1;
            -- count the deleted rows in the recommendedTrees
            SELECT COUNT(*) INTO recommendedTrees_deleted_count
                FROM recommendedTrees WHERE requestID = treeRequestID;
            DELETE FROM siteVisits WHERE requestID = treeRequestID;
        end if;

        SELECT COUNT(requestID) INTO row_count
            FROM treePlantings WHERE requestID = treeRequestID;

        IF row_count = 1 THEN -- the related tree planting event exists, delete it
            SET treePlantings_deleted_count = 1;
            -- count the deleted rows in the volunteerPlants
            SELECT COUNT(*) INTO volunteerPlants_deleted_count
                FROM volunteerPlants WHERE requestID = treeRequestID;
            DELETE FROM treePlantings WHERE requestID = treeRequestID;
        end if;

        DELETE FROM treeRequests WHERE requestID = treeRequestID;

        SET status = CONCAT(status, 'Deleted the tree request(id): ', treeRequestID,
                            ', deleted count of rows in siteVisits: ', siteVisits_deleted_count,
                            ', deleted count of rows in recommendedTrees: ', recommendedTrees_deleted_count,
                            ', deleted count of rows in treePlantings: ', treePlantings_deleted_count,
                            ', deleted count of rows in volunteerPlants: ', volunteerPlants_deleted_count
                     );
    ELSE
        SET status = 'This tree request does not exist!';
    end if;
end //

DELIMITER ;