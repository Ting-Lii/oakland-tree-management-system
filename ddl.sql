CREATE TABLE neighborhoods(
    name VARCHAR(60) NOT NULL,
    district VARCHAR(60),
    description VARCHAR(600),
    CONSTRAINT PK_name PRIMARY KEY (name)
);

-- lookup table for the role
CREATE TABLE roles(
    name VARCHAR(20) NOT NULL,
    CONSTRAINT PK_name PRIMARY KEY (name)
);

CREATE TABLE users(
    uid INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(40),
    lastName VARCHAR(40),
    email VARCHAR(40),
    password VARCHAR(40),
    zipCode VARCHAR(10),
    role VARCHAR(20),
    neighborhood VARCHAR(60) DEFAULT NULL,
    CONSTRAINT PK_uid PRIMARY KEY (uid),
    CONSTRAINT CK_email UNIQUE (email),
    CONSTRAINT FK_role FOREIGN KEY (role)
        REFERENCES roles(name) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_neighborhood FOREIGN KEY (neighborhood)
        REFERENCES neighborhoods(name) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT Check_isvalid_email
        CHECK (email LIKE '%_@_%._%')
);

-- lookup table for the status
CREATE TABLE statuses(
    name VARCHAR(20) NOT NULL,
    CONSTRAINT PK_name PRIMARY KEY (name)
);

CREATE TABLE volunteers(
    vid INT NOT NULL,
    applicationStatus VARCHAR(20),
    availability BOOLEAN,
    CONSTRAINT PK_vid PRIMARY KEY (vid),
    CONSTRAINT FK_volunteer_uid FOREIGN KEY (vid)
        REFERENCES users(uid) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_volunteer_status FOREIGN KEY (applicationStatus)
        REFERENCES statuses(name) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT CK_vid UNIQUE (vid)
);

CREATE TABLE permits(
    permitId VARCHAR(40) NOT NULL,
    rid INT NOT NULL,
    permitStatus VARCHAR(20) NOT NULL,
    issueDate DATE,
    CONSTRAINT PK_permitId PRIMARY KEY (permitId),
    CONSTRAINT FK_permit_uid FOREIGN KEY (rid)
        REFERENCES users(uid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE treeRequests(
    referenceNum VARCHAR(40) NOT NULL,
    rid INT NOT NULL,
    streetAddress VARCHAR(60) NOT NULL,
    zipCode VARCHAR(10) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    amountOfPayment FLOAT DEFAULT 0.0,
    relationshipToProperty VARCHAR(20),
    dateSubmitted DATE NOT NULL,
    requestStatus VARCHAR(20) NOT NULL,
    neighborhood VARCHAR(60),
    CONSTRAINT PK_request_refNum PRIMARY KEY (referenceNum),
    CONSTRAINT FK_tree_request_uid FOREIGN KEY (rid)
        REFERENCES users(uid) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_request_neighborhood FOREIGN KEY (neighborhood)
        REFERENCES neighborhoods(name) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT check_isvalid_payment
        CHECK ( amountOfPayment >= 0.0 )
);

CREATE TABLE treePlantings(
    plantID INT NOT NULL AUTO_INCREMENT,
    requestRefNum VARCHAR(40) NOT NULL,
    eventName VARCHAR(60),
    plantDate DATE,
    streetAddress VARCHAR(60) NOT NULL,
    zipCode VARCHAR(10) NOT NULL,
    photoAfter VARCHAR(200),
    treePlanted VARCHAR(200) NOT NULL,
    aid INT NOT NULL,
    CONSTRAINT PK_plantid PRIMARY KEY (plantID),
    CONSTRAINT FK_planting_requestRefNum FOREIGN KEY (requestRefNum)
        REFERENCES treeRequests(referenceNum) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_planting_aid FOREIGN KEY (aid)
        REFERENCES users(uid) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT CK_planting_refNum UNIQUE (requestRefNum)
);

-- lookup table for the feedback
CREATE TABLE feedbacks(
    name VARCHAR(20) NOT NULL,
    CONSTRAINT PK_feedback PRIMARY KEY (name)
);

CREATE TABLE volunteerPlants(
    plantID INT NOT NULL,
    vid INT NOT NULL,
    workHour FLOAT NOT NULL,
    feedback VARCHAR(20),
    CONSTRAINT PK_plantID_vid PRIMARY KEY (plantID, vid),
    CONSTRAINT FK_plantID FOREIGN KEY (plantID)
        REFERENCES treePlantings(plantID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_volunteer_plant_vid FOREIGN KEY (vid)
        REFERENCES volunteers(vid) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_volunteer_feedback FOREIGN KEY (feedback)
        REFERENCES feedbacks(name) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- plantingZones table.
CREATE TABLE plantingZones(
   zoneID INT AUTO_INCREMENT PRIMARY KEY , -- PK and SK
   hashSites BOOLEAN,
   nearBayLocation BOOLEAN,
   nearUrban BOOLEAN,
   nearNatural BOOLEAN
);

-- siteVisits table
CREATE TABLE siteVisits(
    siteVisitID INT AUTO_INCREMENT PRIMARY KEY,    -- PK/SK
    siteVisitDate DATE NOT NULL,
    visitStatus BOOLEAN DEFAULT FALSE,
    streetAddress VARCHAR(200) NOT NULL,
    powerLine BOOLEAN,
    bedWidth INT,                                  -- max bedWidth here
    photoBefore VARCHAR(255),                      -- Photo before planting
    requestRefNum VARCHAR(40),                     -- FK references treeRequests(referenceNum)
    aid INT,                                       -- FK references users(uid)
-- FK Constraints
    CONSTRAINT FK_requestRefNum FOREIGN KEY (requestRefNum)
        REFERENCES treeRequests(referenceNum)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT FK_aid FOREIGN KEY (aid)
        REFERENCES users(uid)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- trees table.
CREATE TABLE trees(
   treeID INT AUTO_INCREMENT PRIMARY KEY, -- PK and SK
   commonName VARCHAR(50) NOT NULL,
   scientificName VARCHAR(50) NOT NULL,
   height VARCHAR(10) NOT NULL,
   width VARCHAR(10) NOT NULL,
   minPlantingBedWidth INT,
   plantableUnderPowerLines BOOLEAN,
   caNative BOOLEAN,
   droughtTolerance VARCHAR(50),
   growthRate VARCHAR(50),
   foliageType VARCHAR(50),
   debris VARCHAR(100),
   rootDamagePotential VARCHAR(50),
   nurseryAvailability VARCHAR(50),
   visualAttraction VARCHAR(50),
   inventory INT,
   zoneID INT,
   FOREIGN KEY (zoneID) REFERENCES plantingZones(zoneID)
);

-- recommendedTrees table
CREATE TABLE recommendedTrees(
    visitID INT,
    treeID INT,

    CONSTRAINT PK_recommended_trees PRIMARY KEY (visitID, treeID),
    
    FOREIGN KEY (visitID) REFERENCES siteVisits(siteVisitID)
      ON DELETE CASCADE -- if a siteVisit is deleted, delete recommendedTrees rows
      ON UPDATE CASCADE, -- if siteVisitID is updated, update it automatically

    FOREIGN KEY (treeID) REFERENCES trees(treeID)
      ON DELETE CASCADE -- if a tree is deleted, delete recommendedTrees rows
      ON UPDATE CASCADE -- if treeID is updated, update row automatically
);

