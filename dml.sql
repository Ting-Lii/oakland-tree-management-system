-- lookup tables
INSERT INTO userRoles VALUES
    ('admin'),
    ('resident'),
    ('volunteer');
-- for permitstatus, volunteer apply status, tree request status
INSERT INTO requestApplyStatuses VALUES
    ('submitted'),
    ('approved'),
    ('rejected');


INSERT INTO visitStatuses VALUES
    ('submitted'),
    ('scheduled'),
    ('completed'),
    ('canceled');

INSERT INTO droughtTolerances VALUES
    ('Moderate'),
    ('High'),
    ('Very High');

INSERT INTO growthRates VALUES
    ('Slow'),
    ('Moderate'),
    ('Fast'),
    ('Very Fast');

INSERT INTO foliageTypes VALUES
    ('Evergreen'),
    ('Deciduous'),
    ('Drought Deciduous'),
    ('Late Deciduous'),
    ('Semi-evergreen');

INSERT INTO rootDamagePotentials VALUES
    ('Low'),
    ('Moderate'),
    ('High');

INSERT INTO nurseryAvailabilities VALUES
    ('Low'),
    ('Moderate'),
    ('High');

INSERT INTO workloadFeedbacks VALUES
    ('light'),
    ('moderate'),
    ('heavy'),
    ('overload');

INSERT INTO plantingZoneFactors VALUES
    ('Under harsh sites: windy, dry or salty'),
    ('Near bay locations'),
    ('Highly urbanized zones'),
    ('Residential adjacent to natural areas');


INSERT INTO neighborhoods VALUES
    ('Fairview Park','North Oakland','This neighborhood is also considered part of Rockridge or Lower Rockridge, especially the portion south of Alcatraz Avenue. The Fairview Park name arose when the Berkeley Development Company filed a tract map in 1904 covering the area bounded by Dana Street, Alcatraz Avenue, College Avenue, and as far north as the houses on the north side of Woolsey Street between Dana and College.'),
    ('Rockridge','North Oakland','Rockridge is a residential and commercial neighborhood of North Oakland, also known as Lower Rockridge per the map above. The first homes were built in the 1880s (a few still remain), with most of the housing built after 1906 through the 1920s. It spans from 51st Street to Claremont Avenue to Alcatraz, the Berkeley Boarder, and back to Broadway.'),
    ('Bushrod','North Oakland','The Bushrod neighborhood of North Oakland that contains Bushrod Park and one of the best Ethiopian restaurants this side of the Nile, Cafe Colucci. The neighborhood is most likely named for the park. The park is named for Dr. Bushrod Washington James, who owned the land where the park is now and donated it for a park.'),
    ('Temescal','North Oakland','Temescal is a neighborhood in North Oakland centered around Telegraph Avenue and 51st Street. The main artery is Telegraph Ave., with lots of residential area on either side.'),
    ('Piedmont Avenue','North Oakland','Piedmont Avenue is a neighborhood in North Oakland adjacent to Temescal, Rockridge, Mosswood, and the City of Piedmont. Its major features are the Piedmont Avenue shopping and dining district, Piedmont Theatre, Mountain View Cemetery, and Kaiser Permanente Hospital.'),
    ('Golden Gate','North Oakland','Golden Gate is a neighborhood west of San Pablo Avenue, bordered by Berkeley to the north, Emeryville to the west and south, and the Gaskill, and Paradise Park tracts to the east. Gaskill and Paradise Park are considered part of the Golden Gate District by the Golden Gate Community Association and others in the area.'),
    ('Paradise Park', 'North Oakland', 'Some people consider Paradise Park and Gaskill as part of Golden Gate due to the lack of community associations. However, Greenstreets, the de facto authority on neighborhoods, lists them all as independent neighborhoods.'),
    ('Gaskill', 'North Oakland', 'The Gaskill neighborhood derives its name from an early owner of a large tract in the area. DeWitt Clinton Gaskill purchased around 17 acres of land north of Oakland on July 1, 1870. He bought the land from his brother, Rollin, who had purchased the land in November 1869 from George Parsons, a pioneer farmer who had settled in the area in 1851.'),
    ('Santa Fe', 'North Oakland', 'Santa Fe is a neighborhood of North Oakland near UCSF Benioff Oakland Children''s Hospital. The Santa Fe neighborhood is bounded by 52nd Street, Martin Luther King Jr. Way, Lowell Street and 61st Street. '),
    ('Longfellow', 'North Oakland', 'Longfellow is an Oakland neighborhood in North Oakland nestled between Temescal  and Mosswood to the East, Santa Fe to the North, the city of Emeryville to West, and Hoover/Foster (in West Oakland) to the South. '),
    ('Mosswood', 'North Oakland', 'Mosswood is roughly the area between 580 and 40th Street and 24 and Broadway. The name comes from the original owner, J. Mora Moss and his wife, Julia Wood.'),
    ('Clawson', 'West Oakland', 'Clawson is a neighborhood in West Oakland, California which sits under the MacArthur Maze at the gateway to Emeryville and South Berkeley.  For decades a predominantly working class neighborhood, over the past [ten?] years the area has gone through a period of urban revitalization, with new people moving into Clawson. '),
    ('Prescott', 'West Oakland', 'Proximity to BART and the San Francisco freeway offramp make this neighborhood a prime site for the current influx of New Oaklanders, largely young and middle-class people who have left San Francisco due to rising rents there.'),
    ('South Prescott', 'West Oakland', 'South Prescott is a neighborhood of Oakland. is a small Neighborhood located Below the West Oakland Bart station the area has a unique history and a very Multicultural one.'),
    ('Hoover-Foster', 'West Oakland', 'Hoover-Foster is a neighborhood located west of Telegraph and east of San Pablo, named after Hoover Junior High and the now-closed Marcus Foster Middle School. It is sometimes called Hoover-Durant, for Hoover Jr. High and the long-gone Durant Elementary, which was the initial school on the Marcus Foster site.'),
    ('McClymonds', 'West Oakland', 'McClymonds is a neighborhood in West Oakland named for McClymonds High School. It''s mostly a residential neighborhood, but there are also many warehouses, factories, and former warehouses and factories (that are either vacant or that have been repurposed for other uses), especially west of Adeline Street.'),
    ('Ralph Bunche', 'West Oakland', 'Ralph Bunche is a neighborhood of Oakland. About Ralph Bunche on Wikipedia. He was an American political scientist and diplomat, and the first person of color to receive the Nobel Peace Prize in 1950.'),
    ('Oak Center', 'West Oakland', 'The Oak Center redevelopment project area was designated for redevelopment in 1965/1962 1. After the Acorn housing project area, this was the second major area slated for redevelopment by the Oakland Redevelopment Agency. '),
    ('Acorn', 'West Oakland', 'The Acorn neighborhood sits on the eastern half of West Oakland, bordered by the Brush Street / 980 Freeway on the east side, Mandela Parkway on the west (or Union Street according to the City of Oakland), Embarcadero on the south side and 10th Street on the north. '),
    ('Acorn Industrial', 'West Oakland', 'The Acorn Industrial neighborhood of Oakland is just that—industrial. It includes most of the Port of Oakland and a number of businesses related to the port, but there are a few other businesses like Linden Street Brewery, The Dock at Linden Street, and Nellie''s Soulfood. It also includes a large Union Pacific railroad switching yard, and the oft-overlooked Middle Harbor Shoreline Park.');

-- users test data
INSERT INTO users VALUES
    (1,'Cathy','Liu','liu.siyuna3@northeastern.edu','test-pwd-1','94601','admin','Fairview Park'),
    (2,'Ashley','Li','li.ting4@northeastern.edu','test-pwd-2','94618', 'admin','Rockridge'),
    (3,'Yunyu','Guo','guo.yunyu@northeastern.edu','test-pwd-3','94609','admin','Bushrod'),
    (4, 'Brian', 'Wong', 'brianwong@gmail.com', 'test-pwd-4', '94610', 'admin', 'Temescal'),
    (5, 'Diana', 'Chen', 'dchen@icloud.com', 'test-pwd-5', '94611', 'admin', 'Piedmont Avenue'),

    (6, 'Eric', 'Zhang', 'eric.zhang@gmail.com', 'test-pwd-6', '94608', 'resident', 'Golden Gate'),
    (7, 'Fiona', 'Lin', 'fiona_lin@yahoo.com', 'test-pwd-7', '94608', 'resident', 'Paradise Park'),
    (8, 'George', 'Liu', 'george.liu@protonmail.com', 'test-pwd-8', '94608', 'resident', 'Gaskill'),
    (9, 'Helen', 'Wu', 'helenwu@gmail.com', 'test-pwd-9', '94608', 'resident', 'Santa Fe'),
    (10, 'Ivan', 'Sun', 'ivan.sun@yahoo.com', 'test-pwd-10', '94608', 'resident', 'Longfellow'),
    (11, 'Jenny', 'Zhou', 'jenny.z@aol.com', 'test-pwd-11', '94609', 'resident', 'Mosswood'),
    (12, 'Kevin', 'Ma', 'kevinma@outlook.com', 'test-pwd-12', '94608', 'resident', 'Clawson'),
    (13, 'Laura', 'Huang', 'laura.huang@gmail.com', 'test-pwd-13', '94607', 'resident', 'Prescott'),
    (14, 'Mike', 'Xie', 'mike.xie@yahoo.com', 'test-pwd-14', '94615', 'resident', 'South Prescott'),
    (15, 'Nina', 'Yu', 'nina.yu@outlook.com', 'test-pwd-15', '94608', 'resident', 'Hoover-Foster'),

    (16, 'Oscar', 'Tang', 'oscar.tang@gmail.com', 'test-pwd-16', '94607', 'volunteer', 'McClymonds'),
    (17, 'Peter', 'Gao', 'pgao@yahoo.com', 'test-pwd-17', '94607', 'volunteer', 'Ralph Bunche'),
    (18, 'Queenie', 'Luo', 'queenie.luo@outlook.com', 'test-pwd-18', '94607', 'volunteer', 'Oak Center'),
    (19, 'Ray', 'Jiang', 'rayjiang@protonmail.com', 'test-pwd-19', '94607', 'volunteer', 'Acorn'),
    (20, 'Sophia', 'Mei', 'sophia.mei@gmail.com', 'test-pwd-20', '94607', 'volunteer', 'Acorn Industrial'),
    (21, 'Tom', 'Shen', 'tomshen@outlook.com', 'test-pwd-21', '94621', 'volunteer', 'Fairview Park'),
    (22, 'Uma', 'He', 'umahe@yahoo.com', 'test-pwd-22', '94618', 'volunteer', 'Rockridge'),
    (23, 'Victor', 'Ng', 'vng@gmail.com', 'test-pwd-23', '94609', 'volunteer', 'Bushrod'),
    (24, 'Wendy', 'Qin', 'wendy.qin@icloud.com', 'test-pwd-24', '94610', 'volunteer', 'Temescal'),
    (25, 'Xander', 'Yu', 'xander.yu@aol.com', 'test-pwd-25', '94611', 'volunteer', 'Piedmont Avenue');

-- volunteer test data
INSERT INTO volunteers VALUES
    (16, 'approved', 1),
    (17, 'submitted', 1),
    (18, 'approved', 0),
    (19,'approved',1),
    (20,'approved',1),
    (21,'rejected',0),
    (22,'approved',1),
    (23,'approved',1),
    (24,'submitted',1),
    (25,'approved',1);

-- permit test data
INSERT INTO permits VALUES
    ('PRM-0001', 6, 'submitted', '2024-11-15'),
    ('PRM-0002', 7, 'submitted', '2024-12-01'),
    ('PRM-0003', 8, 'approved', '2023-10-21'),
    ('PRM-0004', 9, 'rejected', '2024-01-08'),
    ('PRM-0005', 10, 'submitted', '2025-01-15'),
    ('PRM-0006', 11, 'approved', '2023-07-03'),
    ('PRM-0007', 12, 'submitted', '2024-08-27'),
    ('PRM-0008', 13, 'submitted', '2023-12-19'),
    ('PRM-0009', 14, 'rejected', '2024-04-02'),
    ('PRM-0010', 15, 'approved', '2024-09-05'),
    ('PRM-0011', 6, 'submitted', '2024-03-14'),
    ('PRM-0012', 7, 'approved', '2024-05-22'),
    ('PRM-0013', 8, 'submitted', '2024-07-10'),
    ('PRM-0014', 9, 'submitted', '2023-11-11'),
    ('PRM-0015', 10, 'approved', '2024-02-03'),
    ('PRM-0016', 11, 'rejected', '2023-10-09'),
    ('PRM-0017', 12, 'submitted', '2024-06-30'),
    ('PRM-0018', 13, 'approved', '2024-04-14'),
    ('PRM-0019', 14, 'submitted', '2024-01-28'),
    ('PRM-0020', 15, 'rejected', '2023-09-19');

-- treeRequest test data
INSERT INTO treeRequests VALUES
    (1,6, '5545 Claremont Ave, Oakland', '2024-05-01', '510-555-1234', 50.00, 'owner', '94618', 'submitted', 'Fairview Park'),
    (2,7, '5727 College Ave, Oakland', '2024-05-03', '510-555-5678', 0.00, 'tenant', '94618', 'submitted', 'Rockridge'),
    (3,8, '560 59th St, Oakland, CA 94609', '2024-05-05', '510-555-9012', 100.00, 'property manager', '94609', 'approved', 'Bushrod'),
    (4,9, '5095 Telegraph Ave, Oakland', '2024-05-07', '510-555-3456', 25.00, 'owner', '94610', 'submitted', 'Temescal'),
    (5,10, '175 41st St, Oakland', '2024-05-08', '510-555-7890', 0.00, NULL, '94611', 'approved', 'Piedmont Avenue'),
    (6,11, '5849 San Pablo Ave, Oakland', '2024-05-10', '510-555-1111', 75.00, 'tenant', '94608', 'rejected', 'Golden Gate'),
    (7,12, '1074 63rd St, Oakland', '2024-05-11', '510-555-2222', 60.00, 'owner', '94608', 'submitted', 'Paradise Park'),
    (8,13, '1046 56th St, Oakland', '2024-05-13', '510-555-3333', 30.00, NULL, '94608', 'submitted', 'Gaskill'),
    (9,14, '5650 Market St, Oakland', '2024-05-14', '510-555-4444', 10.00, 'tenant', '94608', 'approved', 'Santa Fe'),
    (10,15, '4201 Market St, Oakland', '2024-05-15', '510-555-5555', 90.00, 'property manager', '94608', 'rejected', 'Longfellow'),
    (11,6, '3838 Telegraph Ave, Oakland', '2024-05-16', '510-555-6666', 110.00, 'owner', '94609', 'submitted', 'Mosswood'),
    (12,7, '1527 34th St, Oakland', '2024-05-17', '510-555-7777', 0.00, 'tenant', '94608', 'approved', 'Clawson'),
    (13,8, '1800 Wood St, Oakland', '2024-05-18', '510-555-8888', 80.00, 'owner', '94607', 'submitted', 'Prescott'),
    (14,9, '890 Brockhurst St rm 18, Oakland', '2024-05-19', '510-555-9999', 0.00, 'tenant', '94608', 'submitted', 'Hoover-Foster'),
    (15,10, '2311A Magnolia St, Oakland', '2024-05-20', '510-555-0000', 65.00, NULL, '94607', 'approved', 'McClymonds'),
    (16,11, '5849 San Pablo Ave, Oakland', '2024-05-12', '510-555-1111', 75.00, 'tenant', '94608', 'approved', 'Golden Gate'),
    (17,6,'21 3rd St, Oakland','2025-01-20','510-555-1403',0.00,'tenant','94607','approved','Acorn Industrial'),
    (18,7,'1221 3rd St, Oakland','2025-02-22','510-555-1443',0.00,'tenant','94607','approved','Acorn Industrial'),
    (19,6, '890 Brockhurst St rm 18, Oakland', '2024-12-15', '510-555-1111', 50.0, 'Owner', '94608', 'approved', 'Hoover-Foster'),
    (20,7, '2311A Magnolia St, Oakland', '2024-12-20', '510-555-2222', 65.0, 'Tenant', '94607', 'approved', 'McClymonds'),
    (21,8, '1911 Union St, Oakland', '2025-01-03', '510-555-3333', 40.0, 'Owner', '94607', 'approved', 'Ralph Bunche'),
    (22,9, '1625 Filbert St, Oakland', '2025-01-10', '510-555-4444', 75.0, 'Property Manager', '94607', 'approved', 'Oak Center'),
    (23,10, '923 Adeline St, Oakland', '2025-02-01', '510-555-5555', 60.0, 'Tenant', '94607', 'approved', 'Acorn'),
    (24,11, '12 3rd St, Oakland', '2025-02-14', '510-555-6666', 55.0, 'Owner', '94607', 'approved', 'Acorn Industrial'),
    (25,6,'560 59th St, Oakland','2024-09-09','510-132-4140',0.00,'owner','94609','approved','Bushrod'),
    (26,7,'95 Telegraph Ave, Oakland','2024-10-19','510-132-5140',0.00,'owner','94610','approved','Temescal'),
    (27,15,'10 63rd St, Oakland','2023-12-05','510-132-4040',0.00,'concerned neighbor','94608','approved','Paradise Park'),
    (28,15,'1074 63rd St, Oakland','2022-10-21','510-132-4040',0.00,'concerned neighbor','94608','approved','Paradise Park'),
    (29,15,'74 63rd St, Oakland','2021-02-09','510-132-4040',0.00,'concerned neighbor','94608','approved','Paradise Park'),
    (30,13,'1800 Wood St, Oakland','2024-09-09','510-891-1240',0.00,'tenant','94607','approved','Prescott'),
    (31,13,'56 59th St, Oakland','2024-12-12','510-891-1240',0.00,'concerned neighbor','94609','approved','Bushrod'),
    (32,14,'5600 59th St, Oakland','2025-01-09','510-555-4444',0.00,'concerned neighbor','94609','approved','Bushrod'),
    (33,14,'5 59th St, Oakland','2021-04-09','510-555-4444',0.00,'concerned neighbor','94609','approved','Bushrod'),
    (34,6,'6 59th St, Oakland','2023-05-09','510-132-4140',0.00,'concerned neighbor','94609','approved','Bushrod'),
    (35,7,'50 Telegraph Ave, Oakland','2022-05-10','510-132-5140',0.00,'concerned neighbor','94610','approved','Temescal'),
    (36,8,'15 Telegraph Ave, Oakland','2024-05-11','510-132-5140',0.00,'concerned neighbor','94610','approved','Temescal'),
    (37,9,'19 Telegraph Ave, Oakland','2023-05-12','510-132-5140',0.00,'concerned neighbor','94610','approved','Temescal'),
    (38,10,'10 Telegraph Ave, Oakland','2024-05-13','510-132-5140',0.00,'concerned neighbor','94610','approved','Temescal');


-- site visit test data
INSERT INTO siteVisits VALUES
    (3, 1, '2025-01-02', 'completed',FALSE,15, 'https://picsum.photos/seed/tree1/600/400'),
    (5,1, '2025-04-20', 'scheduled',FALSE,20,'https://picsum.photos/seed/oaklandstreet/600/400'),
    (9,2, '2024-01-20','completed',TRUE,20,'https://picsum.photos/seed/oaklandstreet/600/400'),
    (12,3,'2024-07-09','completed',FALSE,30,'https://picsum.photos/seed/oaklandstreet/600/400'),
    (15, 5, '2024-02-25', 'scheduled', FALSE, 10, 'https://picsum.photos/seed/visit15/600/400'),
    (16, 4, '2024-03-10', 'completed', TRUE, 25, 'https://picsum.photos/seed/visit16/600/400'),
    (17, 4, '2024-03-15', 'scheduled', FALSE, 18, 'https://picsum.photos/seed/visit17/600/400'),
    (18, 1, '2025-03-22', 'completed', FALSE, 22, 'https://picsum.photos/seed/visit18/600/400'),
    (19, 2, '2025-03-28', 'completed', TRUE, 28, 'https://picsum.photos/seed/visit19/600/400'),
    (20, 1, '2025-04-01', 'scheduled', FALSE, 30, 'https://picsum.photos/seed/visit20/600/400'),
    (21, 1, '2025-04-05', 'scheduled', FALSE, 35, 'https://picsum.photos/seed/visit21/600/400'),
    (22, 2, '2025-04-07', 'completed', TRUE, 40, 'https://picsum.photos/seed/visit22/600/400'),
    (23, 4, '2024-04-10', 'completed', FALSE, 18, 'https://picsum.photos/seed/visit23/600/400'),
    (24, 2, '2024-04-12', 'scheduled', FALSE, 20, 'https://picsum.photos/seed/visit24/600/400'),
    (25, 2, '2025-03-10', 'completed', TRUE, 24, 'https://picsum.photos/seed/visit25/600/400'),
    (26, 5, '2025-03-15', 'completed', FALSE, 18, 'https://picsum.photos/seed/visit26/600/400'),
    (27, 5, '2025-03-20', 'completed', TRUE, 30, 'https://picsum.photos/seed/visit27/600/400'),
    (28, 3, '2025-03-25', 'completed', FALSE, 16, 'https://picsum.photos/seed/visit28/600/400'),
    (29, 5, '2025-03-30', 'completed', TRUE, 22, 'https://picsum.photos/seed/visit29/600/400'),
    (30, 1, '2025-04-02', 'completed', FALSE, 20, 'https://picsum.photos/seed/visit30/600/400'),
    (31, 2, '2025-04-05', 'completed', TRUE, 25, 'https://picsum.photos/seed/visit31/600/400'),
    (32, 3, '2025-04-08', 'completed', FALSE, 19, 'https://picsum.photos/seed/visit32/600/400'),
    (33, 3, '2025-04-10', 'completed', TRUE, 21, 'https://picsum.photos/seed/visit33/600/400'),
    (34, 3, '2025-04-12', 'completed', FALSE, 23, 'https://picsum.photos/seed/visit34/600/400');;

-- insertion for trees
INSERT INTO treeSpecies VALUES
    (1,'African fern pine', 'Afrocarpus gracilior', 40,60,25,35, 5,FALSE, FALSE, 'High', 'Moderate', 'Evergreen', 'Low', 'Moderate', 'High', 'Greenscreen', 10),
    (2,'Aleppo oak', 'Quercus boissieri', 30,40,30,50,5, FALSE, FALSE, 'High', 'Moderate', 'Deciduous', 'Low acorn potential', 'Moderate', 'Low', 'Fall color', 11),
    (3,'Atlas cedar', 'Cedrus atlantica', 60,100,30,45, 6, FALSE, FALSE, 'Very high', 'Fast', 'Evergreen', 'Low', 'High', 'Low', 'Structure', 12),
    (4,'Brisbane box', 'Lophostemon confertus', 40,60,25,40, 5, FALSE, FALSE, 'Moderate', 'Moderate', 'Evergreen', 'Low', 'Moderate', 'High', 'Bark', 13),
    (5,'Bronze loquat', 'Eriobotrya deflexa', 15,25,20,30, 3, TRUE, FALSE, 'Moderate', 'Moderate', 'Evergreen', 'Moderate', 'Low', 'Moderate', 'Foliage, flowers', 14),
    (6,'Cajeput tree', 'Melaleuca quinquenervia', 20,35,15,35, 4, FALSE, FALSE, 'Very high', 'Moderate', 'Evergreen', 'Low', 'Moderate', 'High', 'Bark, flower', 15),
    (7,'California buckeye', 'Aesculus californica', 20,30,20,50, 8, TRUE, TRUE, 'High', 'Slow', 'Drought deciduous', 'Large seeds', 'Moderate', 'Moderate', 'Structure, fruit', 16),
    (8,'Canary Island pine', 'Pinus canariensis', 60,100,20,40, 8, FALSE, FALSE, 'Very high', 'Fast', 'Evergreen', 'Large cones, limb failure', 'High', 'High', 'Foliage, bark', 17),
    (9,'Catalina cherry', 'Prunus lyonii', 15,30,10,30,8, TRUE, TRUE, 'High', 'Moderate', 'Evergreen', 'High fruit potential', 'Low', 'Moderate', 'Flower, foliage', 18),
    (10,'Chestnut leaf oak', 'Quercus castaneifolia', 50,100,30,60, 6, FALSE, FALSE, 'High', 'Very fast', 'Deciduous', 'High acorn potential', 'High', 'Low', 'Size, structure', 19);

INSERT INTO treeToPlantingZones VALUES
    ('Highly urbanized zones', 1),
    ('Residential adjacent to natural areas',1),
    ('Highly urbanized zones', 2),
    ('Residential adjacent to natural areas',2),
    ('Highly urbanized zones', 3),
    ('Residential adjacent to natural areas',3),
    ('Near bay locations',4),
    ('Highly urbanized zones', 4),
    ('Highly urbanized zones', 5),
    ('Under harsh sites: windy, dry or salty',6),
    ('Near bay locations',6),
    ('Highly urbanized zones',6),
    ('Residential adjacent to natural areas',7),
    ('Near bay locations',8),
    ('Highly urbanized zones',8),
    ('Residential adjacent to natural areas',8),
    ('Highly urbanized zones',9),
    ('Residential adjacent to natural areas',9),
    ('Highly urbanized zones',10),
    ('Residential adjacent to natural areas',10);

-- recommended trees
INSERT INTO recommendedTrees VALUES
    (3, 4),
    (3, 7),
    (9, 1),
    (9, 5),
    (12, 2),
    (12, 6),
    (25, 3),
    (25, 9),
    (26, 8),
    (26, 10),
    (27, 2),
    (27, 7),
    (28, 5),
    (28, 10),
    (29, 1),
    (29, 6),
    (30, 4),
    (30, 9),
    (31, 2),
    (31, 8),
    (32, 3),
    (32, 5),
    (33, 7),
    (33, 10),
    (34, 6),
    (34, 8);


-- treePlanting test data
INSERT INTO treePlantings VALUES
    (3,  '2025-01-12', 'https://picsum.photos/seed/plant3/600/400', 1, 1),
    (9,  '2025-02-08', 'https://picsum.photos/seed/plant9/600/400', 2, 2),
    (12, '2025-02-14', 'https://picsum.photos/seed/plant12/600/400', 3, 3),
    (25, '2024-10-30', 'https://picsum.photos/seed/plant25/600/400', 4, 4),
    (26, '2024-12-03', 'https://picsum.photos/seed/plant26/600/400', 5, 5),
    (27, '2024-03-05', 'https://picsum.photos/seed/plant27/600/400', 1, 6),
    (28, '2022-12-07', 'https://picsum.photos/seed/plant28/600/400', 1, 5),
    (29, '2021-03-09', 'https://picsum.photos/seed/plant29/600/400', 3, 1),
    (30, '2024-12-11', 'https://picsum.photos/seed/plant30/600/400', 2, 4),
    (31, '2025-03-13', 'https://picsum.photos/seed/plant31/600/400', 5, 2),
    (32, '2025-03-15', 'https://picsum.photos/seed/plant32/600/400', 5, 3),
    (33, '2022-03-17', 'https://picsum.photos/seed/plant33/600/400', 4, 7),
    (34, '2023-12-19', 'https://picsum.photos/seed/plant34/600/400', 3, 8),
    (35, '2022-05-21', 'https://picsum.photos/seed/plant35/600/400', 2, 9),
    (36, '2024-07-22', 'https://picsum.photos/seed/plant36/600/400', 1, 10),
    (37, '2024-03-23', 'https://picsum.photos/seed/plant37/600/400', 3, 11),
    (38, '2024-08-24', 'https://picsum.photos/seed/plant38/600/400', 2, 12);


-- volunteerPlants test data
INSERT INTO volunteerPlants VALUES
    (3, 16, 3.0, 'moderate'),
    (3, 17, 4.0, 'moderate'),
    (3, 18, 2.5, 'light'),

    (9, 19, 5.0, 'overload'),
    (9, 20, 3.5, 'moderate'),
    (9, 21, 2.0, 'light'),

    (12, 22, 4.5, 'heavy'),
    (12, 23, 3.0, 'moderate'),
    (12, 24, 2.5, 'light'),

    (25, 25, 4.0, 'moderate'),
    (25, 16, 5.5, 'overload'),
    (25, 17, 3.0, 'heavy'),

    (26, 18, 3.0, 'moderate'),
    (26, 19, 4.0, 'heavy'),
    (26, 20, 3.5, 'light'),

    (27, 21, 4.5, 'heavy'),
    (27, 22, 2.5, 'moderate'),
    (27, 23, 5.0, 'overload'),

    (28, 24, 2.5, 'light'),
    (28, 25, 3.0, 'moderate'),
    (28, 16, 4.0, 'heavy'),

    (29, 16, 4.0, 'heavy'),

    (30, 17, 3.5, 'moderate'),

    (31, 18, 2.0, 'light'),

    (32, 19, 4.0, 'overload'),

    (33, 20, 2.5, 'moderate'),
    (33, 21, 3.5, 'moderate'),
    (33, 22, 4.5, 'heavy');
