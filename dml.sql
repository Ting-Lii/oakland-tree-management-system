INSERT INTO roles VALUES
    ('admin'),
    ('resident'),
    ('volunteer');

INSERT INTO statuses VALUES
    ('submitted'),
    ('pending'),
    ('approved'),
    ('rejected');

INSERT INTO feedbacks VALUES
    ('light'),
    ('moderate'),
    ('heavy'),
    ('overload');

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
    ('Acron', 'West Oakland', 'The Acorn neighborhood sits on the eastern half of West Oakland, bordered by the Brush Street / 980 Freeway on the east side, Mandela Parkway on the west (or Union Street according to the City of Oakland), Embarcadero on the south side and 10th Street on the north. '),
    ('Acron Indusctrial', 'West Oakland', 'The Acorn Industrial neighborhood of Oakland is just that—industrial. It includes most of the Port of Oakland and a number of businesses related to the port, but there are a few other businesses like Linden Street Brewery, The Dock at Linden Street, and Nellie''s Soulfood. It also includes a large Union Pacific railroad switching yard, and the oft-overlooked Middle Harbor Shoreline Park.');

-- users test data
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('1', 'Leola', 'Swaniawski', 'Margaretta_Jerde@yahoo.com', 'kG7D7qOErnvU6CG', '24043', 'Clawson','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('2', 'Ayla', 'Kulas', 'Marielle.Purdy@gmail.com', 'VPMOiyHElaAgEc5', '57083', 'Santa Fe','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('3', 'Beverly', 'Blanda', 'Brook.Krajcik@hotmail.com', 'q3NJUoE5uuPVxP3', '99108', 'Paradise Park','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('4', 'Jude', 'Towne', 'Amani_Mayert11@hotmail.com', 'cNUuT_1hYhm1eaA', '33556', 'Bushrod','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('5', 'Lonzo', 'Welch', 'Ian.Aufderhar@gmail.com', 'IyeTJGm_eRDUYf0', '39129', 'Acron','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('6', 'Lavonne', 'Ziemann', 'Orrin_Bednar@yahoo.com', 'RceeUDtKhAqMTsO', '15959', 'Paradise Park','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('7', 'Natasha', 'Baumbach', 'Antonette_Ankunding28@gmail.com', 'vhFwNRPZwYip6dO', '00790', 'Acron','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('8', 'Lyda', 'Schneider', 'Katrine25@yahoo.com', 'wqqqNhmWJgAWFKw', '77908', 'McClymonds','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('9', 'Ryder', 'Torphy', 'Valerie97@yahoo.com', 'EiyLHJvxMdUanio', '75103', 'Temescal','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('10', 'Tod', 'Barton', 'Josiane.Becker@yahoo.com', 'BWuekb8JCGTsXIh', '79116', 'Acron','admin');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('11', 'Leon', 'Larkin', 'Will_Brakus@gmail.com', 'VOQpfq5S9_PNKEz', '35328', 'Piedmont Avenue', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('12', 'Sharon', 'Abbott', 'Ben.Stanton4@yahoo.com', 'AzXSHAXq20fslta', '32950', 'Fairview Park', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('13', 'Lavon', 'Funk', 'Hudson66@yahoo.com', 'KyeXB7_0BuxEEqe', '97492', 'Clawson', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('14', 'Cathy', 'Foo', 'Cathy.liu@yahoo.com', 'testpwd', '94143', 'Clawson', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('15', 'Carmine', 'Mayert', 'Kamille_Kutch@yahoo.com', 'XlkDF0Hc7duhTdy', '21640', 'Fairview Park', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('16', 'Kitty', 'Skiles', 'Shania_Boyer33@gmail.com', 'Cv2lwspa_IaOOLj', '48557', 'Golden Gate', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('17', 'Roselyn', 'Herzog', 'Terry1@gmail.com', 'ZNHpqHD9jpNnS4m', '66478', 'Paradise Park', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('18', 'Ora', 'Hauck', 'Bulah17@gmail.com', '4pTWNrPMYZW8wuo', '99485', 'Hoover-Foster', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('19', 'Alford', 'Glover', 'Marcelle_Harvey@gmail.com', 'K9SXmqh4vTLme6D', '69355', 'Santa Fe', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('20', 'Tamia', 'Hansen', 'Emmett_Schmitt40@hotmail.com', 'o6eXnGGugbP0SD7', '08695', 'Rockridge', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('21', 'Braulio', 'Cormier', 'Haley.Cassin@yahoo.com', '2NgOmNIPQq3LVeC', '27851', 'South Prescott', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('22', 'Justyn', 'Torphy', 'Brice91@yahoo.com', 'TLSBlq6ad6uOEPw', '31444', 'South Prescott', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('23', 'Gonzalo', 'Friesen', 'Paige.Hane28@gmail.com', '0heKIHMgSx2pC7D', '75516', 'Mosswood', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('24', 'Pete', 'Kulas', 'Leonie98@gmail.com', 'S46DNoKF_3wAAZp', '69293', 'Golden Gate', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('25', 'Emelia', 'Bayer-Considine', 'Amos.Feest43@yahoo.com', 'Ock6cOhKkT60gc1', '67499', 'Acron Indusctrial', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('26', 'Laney', 'Runolfsson-Sipes', 'Dean_Kris@yahoo.com', '01FuDs4ogDVgNeN', '57823', 'Clawson', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('27', 'Johan', 'Dare', 'Enid_Bode24@gmail.com', 'O1ygIfcyuT995BD', '38629', 'Clawson', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('28', 'Cielo', 'Hauck', 'Josianne_Strosin@hotmail.com', 'b3XZ4_phbo33RP1', '96655', 'McClymonds', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('29', 'Rashawn', 'Hartmann', 'Johnnie_Reinger@gmail.com', 'F_LpRmJtCsKc6x0', '34863', 'Temescal', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('30', 'Lamont', 'Von', 'Eulah.Sanford@hotmail.com', '4LfDSJCfo8buQ5V', '83727', 'Acron Indusctrial', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('31', 'Hilton', 'Reichert-Johnson', 'Cristobal_Mosciski@hotmail.com', '7kPj4vI7Fc3S77D', '60084', 'Temescal', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('32', 'Jaden', 'Kunze', 'Lane_Collins@gmail.com', '9b8z4wyNcWozCcD', '38431', 'Ralph Bunche', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('33', 'Jaden', 'Durgan', 'Clyde.Funk76@gmail.com', 'JuTOKQb_eWLaaHg', '85328', 'Fairview Park', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('34', 'Johathan', 'Simonis', 'Jayde_Lang92@gmail.com', 'dnNXCHBVLtsyZmt', '06708', 'Clawson', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('35', 'Theron', 'Murphy', 'Immanuel.Abernathy@gmail.com', 'RZzUXpNy0ndJmZp', '79459', 'Santa Fe', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('36', 'Zelma', 'Cronin', 'Watson_Moore23@yahoo.com', '2cCdjgfhBbbvOO6', '75318', 'Mosswood', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('37', 'Jed', 'MacGyver', 'Gonzalo.Romaguera92@hotmail.com', 'xyYgTE3LuC6pJmT', '98255', 'Piedmont Avenue', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('38', 'Ariane', 'Daniel', 'Odessa34@gmail.com', 'Cr2vIaqGhgRZrn9', '51000', 'Longfellow', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('39', 'Brennon', 'Mante', 'Maryjane_Abshire3@yahoo.com', 'HeYmu1duStGjzJO', '30447', 'McClymonds', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('40', 'Travis', 'Beer', 'Loyal_Haley@gmail.com', 'InjYQilh3vuY9Ad', '97638', 'Longfellow', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('41', 'Kaylin', 'Parisian', 'Cornell84@hotmail.com', 'GHGuSXEh4x6NpHw', '33844', 'Hoover-Foster','resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('42', 'Blake', 'Bins', 'Pinkie_Gulgowski9@hotmail.com', '351ySf6Dt169UEU', '77593', 'Golden Gate', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('43', 'Angela', 'Zemlak', 'Patrick_Jast-Ruecker@hotmail.com', 'q8qrO7x3zixIaEf', '51818', 'South Prescott', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('44', 'Rosalyn', 'Monahan', 'Elton17@yahoo.com', 'bLpL7WgYt07hm5h', '12556', 'Acron Indusctrial', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('45', 'Clement', 'Bednar', 'Stevie42@hotmail.com', 'HwH5PAY830ln0e7', '92153', 'Acron', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('46', 'Owen', 'Nolan', 'Wilton16@yahoo.com', 'e6dJhKchyx_9wFE', '18856', 'Hoover-Foster', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('47', 'Madeline', 'Mann', 'Ilene_Pacocha@yahoo.com', 'vE0bcFJlE5Tggjp', '72028', 'Paradise Park', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('48', 'Marcos', 'Klocko', 'Rosemarie_Toy@hotmail.com', 'NU6Omb14T4vHDPp', '85682', 'Bushrod', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('49', 'Percy', 'Schiller', 'Trevion.Hyatt@gmail.com', 'VafmC7msG_utWuK', '70983', 'Fairview Park', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('50', 'Treva', 'Fay', 'Andreane36@yahoo.com', 'wyMZyWx7b5Uzirf', '01044', 'Piedmont Avenue', 'resident');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('51', 'Katelynn', 'Braun', 'Gerda51@yahoo.com', 'N1T4fH1uit3lt8V', '65860', 'Ralph Bunche', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('52', 'Bella', 'Barrows', 'Dangelo_Koch65@yahoo.com', 'aJevsUa27xu5YO2', '81785', 'Ralph Bunche', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('53', 'Mack', 'Konopelski', 'Macey.Krajcik25@yahoo.com', 'VkmeMvNp8FU6JxD', '07520', 'Mosswood', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('54', 'Jedediah', 'Halvorson', 'Tressie.Schinner@yahoo.com', 'EBTSMafMWMWpLzd', '69630', 'Longfellow', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('55', 'Helmer', 'Greenholt', 'Patrick.Kohler@yahoo.com', 'ZBUpT2EYdEMhtuA', '32391', 'Prescott', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('56', 'Raymond', 'Abshire', 'Austin70@yahoo.com', '0qsKUx6FFsF6ewC', '79618', 'Acron', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('57', 'Pansy', 'Kihn', 'Don.Koch13@hotmail.com', 'yeb8IUjwx8E6kMw', '25559', 'Clawson', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('58', 'Jena', 'Homenick', 'Anabel_Schamberger57@yahoo.com', 'JzRkxLOzNNd34b6', '12289', 'Golden Gate', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('59', 'Heidi', 'Mertz', 'Mitchell16@hotmail.com', '46z37UvKqMmzAmp', '51004', 'Gaskill', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('60', 'Zelma', 'Wilderman', 'Javon_Hamill@yahoo.com', 'zwVcYL9jM2HNEZb', '15328', 'Oak Center', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('61', 'Darion', 'Moen', 'Julianne_Johnston41@yahoo.com', '7ed6GyL1yTcQvAx', '08480', 'Acron', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('62', 'Beulah', 'Hegmann', 'Destiney40@gmail.com', 'Qfy6ljPiGU07Ylq', '16846', 'Clawson', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('63', 'Lexi', 'Mayer', 'Ricky.Koepp@gmail.com', 'ebOnHrXgHodg5TO', '00313', 'Santa Fe', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('64', 'Timmy', 'Feil', 'Litzy.Swift13@yahoo.com', 'PuMAZNfyStvHJBt', '78523', 'Oak Center', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('65', 'Breana', 'Senger', 'Kareem.Lang@yahoo.com', 'kVqFUaxmlXR2PFP', '45174', 'McClymonds', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('66', 'Isabell', 'Stoltenberg', 'Waldo90@yahoo.com', '2UpDwadnmBx2LHs', '01906', 'Piedmont Avenue', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('67', 'Elwyn', 'Medhurst-Hoeger', 'Suzanne_Kassulke-Ruecker13@gmail.com', '0e5jHKInxrEIWGJ', '59562', 'Paradise Park', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('68', 'Dannie', 'Bernier', 'Coralie.Schmidt92@hotmail.com', 'NR0o32Vi9Od9Jkc', '92304', 'Rockridge', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('69', 'Abigale', 'Altenwerth', 'Jean.Botsford@yahoo.com', 's8iTTe9OP1hGGiV', '60357', 'Longfellow', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('70', 'Angelita', 'Donnelly', 'Dorothy_OReilly@yahoo.com', '9sR3nOmvQ_1g2oE', '89337', 'Oak Center', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('71', 'Reina', 'Legros', 'Shemar_Jacobi87@yahoo.com', '39AkHKJQJeQB0cF', '05450', 'Santa Fe', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('72', 'Winston', 'Koss', 'Kurtis85@yahoo.com', 'bSTbJEV2i9o2ADm', '42710', 'Prescott', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('73', 'Quentin', 'Paucek', 'Vickie10@hotmail.com', 'r2qRFJ8WScGFk7R', '50472', 'Oak Center', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('74', 'Neva', 'Kihn', 'Donna.Mitchell39@hotmail.com', 'z7qjizO22E345SY', '91232', 'South Prescott', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('75', 'Rosanna', 'Donnelly', 'Eileen12@gmail.com', 'alqJJZFiazSLOEM', '45731', 'Mosswood', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('76', 'Ursula', 'Robel', 'Cody82@gmail.com', 'fSE6Vm7LOjpQodt', '30424', 'McClymonds', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('77', 'Howell', 'Satterfield', 'Odessa66@gmail.com', 'KUJcOxxqGxPxYlZ', '24168', 'Santa Fe', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('78', 'Priscilla', 'Kohler', 'Elvera.Kris@hotmail.com', 'VqVAplBn52sVVp5', '80079', 'Rockridge', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('79', 'Elinore', 'Borer', 'Alexandre11@hotmail.com', 'N_IUsX6MK6KYHq2', '46351', 'Acron', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('80', 'Tamia', 'Pagac', 'Sophia_Leuschke18@gmail.com', 'NGv4YWpYZD04aQP', '36309', 'Fairview Park', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('81', 'Vito', 'Mann', 'Linwood_McClure@yahoo.com', 'TaPURkXCQwca3WY', '44619', 'Acron Indusctrial', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('82', 'Jovan', 'Mann-Robel', 'Curt42@hotmail.com', 'Hp8zrgN_zKGu479', '06016', 'Ralph Bunche', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('83', 'Dolores', 'Conroy', 'Brady.Crooks@hotmail.com', '40ilKfHa2hmQQDT', '62676', 'Oak Center', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('84', 'Lindsay', 'Jerde', 'Frederique_Rowe-Cummings93@gmail.com', 'mNHO6L7SnWsz_3v', '42460', 'Acron', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('85', 'Eugene', 'Keebler', 'Cecil8@yahoo.com', 'DUEzFJIUOEhEnX8', '15496', 'Paradise Park', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('86', 'Rudy', 'Lang', 'Eldridge_Emard@gmail.com', 'CwWwytdUkt1XWa2', '48524', 'South Prescott', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('87', 'Simeon', 'Brekke', 'Dora_Kiehn@yahoo.com', '7VTunNXzkEkOIHB', '33465', 'South Prescott', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('88', 'Fidel', 'Predovic', 'Elouise18@hotmail.com', 'woszlErmaBxVKKD', '58943', 'Fairview Park', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('89', 'Thad', 'Douglas', 'Keyshawn_Kuhn@yahoo.com', 'DrY4NH62gkogpJG', '42100', 'McClymonds', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('90', 'Mazie', 'Kuhlman', 'Macie_Zieme@yahoo.com', '85jNxqFMYtFTIkY', '74325', 'Ralph Bunche', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('91', 'Thea', 'Nitzsche', 'Fannie_Gutkowski33@yahoo.com', 'Tr7M1E7tC6TMSFg', '18078', 'Gaskill', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('92', 'Rigoberto', 'Murphy', 'Corine_Schmidt@yahoo.com', '8sQCIzl6TsDxukD', '86429', 'Ralph Bunche', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('93', 'Karianne', 'Streich', 'Kamille_Schneider12@gmail.com', 'FBu6XlaieIUsRZD', '22426', 'South Prescott', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('94', 'Elmer', 'Welch', 'Liliane_Glover3@yahoo.com', 'fuyYMmgyviWMyQi', '17444', 'Golden Gate', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('95', 'Marcus', 'Gibson', 'Diana.Skiles31@yahoo.com', '87CN0WyS_8ZpVMK', '97757', 'Temescal', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('96', 'Miles', 'Wisoky', 'Claude_Lueilwitz53@hotmail.com', 'xT_fCl78X6cUe3B', '95318', 'Clawson', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('97', 'Marina', 'Mills', 'Dell98@hotmail.com', 'gakAREPBAAtipDl', '22250', 'Fairview Park', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('98', 'Nichole', 'Greenholt', 'Collin37@gmail.com', 'TvjICQxfB4dAqdb', '09295', 'Clawson', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('99', 'Kaleigh', 'Raynor', 'Chaya_Wiegand83@gmail.com', 'KxscyQ_pXBE6ofP', '59359', 'Acron', 'volunteer');
INSERT INTO users (uid, firstName, lastName, email, password, zipCode, neighborhood, role) VALUES ('100', 'Marian', 'Kulas', 'Wade_Feest-Reichel@hotmail.com', 'eW0dgiS5u43sjGy', '93065', 'Santa Fe', 'volunteer');

-- volunteer test data
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('51', 'approved', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('52', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('53', 'approved', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('54', 'submitted', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('55', 'pending', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('56', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('57', 'approved', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('58', 'approved', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('59', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('60', 'approved', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('61', 'submitted', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('62', 'rejected', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('63', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('64', 'pending', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('65', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('66', 'approved', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('67', 'approved', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('68', 'approved', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('69', 'submitted', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('70', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('71', 'submitted', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('72', 'pending', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('73', 'rejected', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('74', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('75', 'rejected', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('76', 'rejected', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('77', 'approved', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('78', 'pending', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('79', 'rejected', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('80', 'pending', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('81', 'submitted', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('82', 'pending', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('83', 'approved', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('84', 'submitted', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('85', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('86', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('87', 'rejected', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('88', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('89', 'submitted', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('90', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('91', 'rejected', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('92', 'pending', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('93', 'submitted', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('94', 'submitted', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('95', 'rejected', '1');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('96', 'pending', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('97', 'approved', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('98', 'pending', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('99', 'pending', '0');
INSERT INTO volunteers (vid, applicationStatus, availability) VALUES ('100', 'approved', '1');

-- permit test data
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('ffbd6a6f-835c-48cf-ad22-1c63a8284d07', '11', 'pending', '2005-08-14T09:32:05.652');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('4a185cbf-8b43-4ecf-8c98-77f523ec424b', '12', 'rejected', '2018-09-11T20:42:30.935');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('4c2d8570-047b-4244-8837-9a5877b07395', '13', 'approved', '2008-01-06T00:51:08.020');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('7a3a5ce7-4834-4c4b-a777-a280e1b6fddd', '14', 'rejected', '2024-02-03T10:22:40.965');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('67e2f1a4-81c9-4825-808d-66d1329ea4bc', '15', 'rejected', '1995-03-08T20:08:10.484');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('e519f82f-f69f-4acf-9cff-d4d2b5ff07ed', '16', 'approved', '1999-11-03T08:18:34.824');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('d0fbf162-819c-4ccf-94c5-a5111f3ee464', '17', 'pending', '1996-12-10T08:36:49.483');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('c7e48003-865e-4093-afd2-4b19bb14ca7f', '18', 'pending', '2022-06-15T19:34:53.133');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('4d916b51-6f10-4483-8dc1-bd2bcebcaeb4', '19', 'submitted', '2000-09-27T21:53:41.536');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('ecbb64f2-d662-4851-be5b-bfa972bd233d', '20', 'approved', '2005-04-20T16:50:02.497');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('d7f1c79e-99e5-4054-8f26-fbf6253cb669', '21', 'submitted', '2023-01-01T11:47:12.921');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('cce57951-6c9d-4f83-b9d8-181f4fe224e6', '22', 'approved', '2004-02-15T15:08:31.031');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('7c56354f-5fb6-4856-9b39-3dc1a170e84c', '23', 'approved', '2006-12-16T11:44:35.561');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('76da15da-9e87-458f-9b66-d2d64bd654fa', '24', 'pending', '1998-12-23T00:06:31.359');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('01d4548b-cb17-47d4-a173-978d211b6d1a', '25', 'approved', '1999-07-27T10:36:24.705');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('dbd1874c-c4bf-40e5-bc94-25546d529de9', '26', 'pending', '1990-09-02T20:45:13.510');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('b6eacab4-44e4-45f3-986e-c0f294a76242', '27', 'pending', '2014-03-12T05:22:44.624');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('a54b961f-8aed-47a9-92d7-72a30f0a8f21', '28', 'submitted', '1999-08-20T17:20:03.106');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('6272f15e-305c-431e-9b87-fb8516096055', '29', 'approved', '1990-11-11T11:25:10.389');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('a6447454-3748-4cca-b83c-bb66cdf03892', '30', 'rejected', '2017-04-28T07:26:02.008');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('a5cbafe1-f558-42ff-af08-fe41d23b1f4f', '31', 'pending', '2010-12-04T22:43:57.647');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('3b72f4fe-ce62-4415-9056-49fd9320b95f', '32', 'pending', '2013-07-23T07:23:34.664');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('dbd786c4-8511-4b12-b515-0ae988e9e550', '33', 'rejected', '2021-01-19T19:47:38.972');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('09b1060f-91c5-4eda-a156-7a97044dc0ba', '34', 'pending', '1997-06-19T04:18:48.049');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('ccce066b-c299-41ad-9ccf-c8cee5985d3d', '35', 'submitted', '2021-10-22T16:08:33.280');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('6850b77e-337c-456a-bd8c-48da516dd11a', '36', 'submitted', '2013-05-17T07:38:10.931');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('1ec66447-27d6-4bd1-a6dd-6096bda9971d', '37', 'submitted', '2014-10-20T11:48:09.795');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('5a4626b6-692d-4a12-84f9-82bee13f777b', '38', 'rejected', '2000-12-19T00:33:18.995');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('e0844e51-7e7a-44f8-b96e-6d68c4ecfd87', '39', 'approved', '2014-05-08T23:55:25.929');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('399b8fa8-06f7-43dc-b929-5a76cf631d28', '40', 'pending', '2018-06-24T01:42:52.546');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('25f855d5-a19d-426b-9447-338fa8ea835d', '41', 'submitted', '2021-04-06T01:55:28.771');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('bc8f679c-1dca-4050-a823-f1e72269e5f6', '42', 'submitted', '2012-12-22T23:51:56.733');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('ea7d131a-7e70-46c4-9533-445ab76314be', '43', 'submitted', '2023-01-13T18:15:31.182');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('e8df3a6a-7afc-480c-86ac-05e7aa4b547d', '44', 'rejected', '2020-12-31T01:59:22.671');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('d7e8fc5d-fde5-414f-91bc-44501cc0052f', '45', 'approved', '1999-10-15T10:11:01.854');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('fe2ecad1-01af-47a5-a893-c4ba1f0a2b7c', '46', 'rejected', '1990-04-22T23:27:17.886');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('817d5a21-7057-45d7-bc19-e7dc3f2efc25', '47', 'rejected', '2022-10-17T04:59:15.452');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('200b2557-d215-42fd-a1a5-c59c10d59c23', '48', 'pending', '2009-07-10T23:43:36.481');
INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES ('b334e2ff-7402-4413-b770-ea2af6d484c6', '49', 'rejected', '2018-03-15T06:02:08.836');

-- treeRequest test data
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('1fef06e1-a710-4e05-b921-b84e40c41ea2', '23', 'N Central Avenue', '83604', '(556)969-0541', '270.44', ' renting tenant', '1991-03-12T04:35:28.140', 'submitted', 'Oak Center');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('061f30bf-5df5-45f2-8e21-87dd9d1ed116', '46', 'Hickle Roads', '73216', '(043)856-8834', '81.08', ' concerned neighbor', '1991-11-21T15:55:00.632', 'approved', 'Acron Indusctrial');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('25554ef2-9e30-4022-ad1a-3afdc1cb8098', '24', 'Silver Street', '45466', '(908)779-2439', '111.96', 'others', '2023-08-09T13:23:20.542', 'approved', 'Gaskill');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('af63b711-b03c-4468-8096-b0055514eab7', '39', 'Buckingham Road', '26406', '(335)197-0405', '193.28', 'others', '2008-07-01T22:20:44.203', 'pending', 'Clawson');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('f161c5fe-82ba-4921-9026-e350a5f29e2c', '22', 'S Main Street', '95619', '(907)664-2277', '937.66', ' concerned neighbor', '1995-10-06T23:22:08.560', 'pending', 'Acron');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('f9909b0b-2ae5-4435-b455-7c69d891e500', '27', 'Leilani Alley', '08920', '(833)478-2894', '202.01', 'others', '2022-02-20T02:55:06.826', 'rejected', 'Bushrod');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('a6fd6eca-9e70-4fa8-ae8c-374032c6dd78', '16', 'Sibyl Ways', '99614', '(710)172-4007', '770.9', ' owner', '2018-12-28T21:51:33.325', 'approved', 'Fairview Park');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('0dacec47-6ccd-4a91-a673-5b709c3c6091', '26', 'Hillside Road', '67979', '(719)630-1046', '91.09', ' owner', '2013-09-23T07:22:49.368', 'submitted', 'Oak Center');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('e75dc2b2-bcd9-443c-a59c-53a6dbcc44fd', '18', 'Harley Circles', '33769', '(105)315-0486', '300.78', ' concerned neighbor', '2006-04-23T22:25:04.359', 'approved', 'McClymonds');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('2e61bd4f-aed5-4981-9bb5-75a02de12d3e', '41', 'Post Road', '90307', '(065)290-7760', '399.73', ' owner', '1991-01-08T19:05:27.625', 'submitted', 'Prescott');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('beac10b7-de7b-486b-910d-d8228242ae16', '26', 'Winfield Stravenue', '61841', '(834)639-4446', '975.91', ' renting tenant', '2014-12-17T17:50:41.577', 'rejected', 'South Prescott');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('8cc7a2c9-083c-49ff-b9ab-e86aa4987c0f', '16', 'Oakfield Road', '09628', '(940)403-0986', '444.58', ' owner', '2018-04-10T09:45:08.193', 'rejected', 'McClymonds');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('c0e064aa-02ae-4766-8c29-c8e310a77c5d', '48', 'Woodlands Avenue', '80466', '(274)190-0936', '631.01', ' concerned neighbor', '2005-12-11T18:43:15.211', 'pending', 'Longfellow');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('66aef077-62ed-4b25-a815-bbe35933aa73', '30', 'Veterans Memorial Highway', '18604', '(470)839-7872', '571.25', 'others', '2022-06-22T00:07:07.041', 'rejected', 'Fairview Park');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('f1a10d30-5ffb-48ca-b539-0528748506d7', '26', 'S Mill Street', '13484', '(778)298-4896', '698.68', 'others', '2005-02-22T15:41:54.464', 'submitted', 'Fairview Park');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('c74d7002-7a06-49a9-8513-39138f031e58', '28', 'Brigitte Loaf', '72521', '(436)007-3360', '437.87', 'others', '2022-11-28T02:55:55.826', 'pending', 'Santa Fe');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('82ae762d-935f-4baf-8b69-dcea9a902223', '47', 'Noemi Dam', '11760', '(350)053-4384', '887.64', ' owner', '2013-10-27T04:27:08.659', 'submitted', 'Mosswood');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('0c131392-8491-493e-92ed-c941aa7207e4', '32', 'Buckingham Road', '50687', '(665)993-7928', '716.06', ' renting tenant', '1994-10-29T19:33:23.154', 'approved', 'Prescott');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('7adaa73f-2205-4746-ae3c-dac7514c786a', '31', 'Manchester Road', '62752', '(092)756-2712', '55.33', ' concerned neighbor', '2017-08-07T05:02:42.032', 'pending', 'Golden Gate');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('f8fb5ce1-a7cc-408d-bfcf-90cb43934f97', '36', 'Bahringer Flat', '28112', '(828)589-2178', '367.93', ' concerned neighbor', '1993-09-19T15:20:59.239', 'rejected', 'Acron Indusctrial');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('90d267b4-5c59-4940-a567-e9ec628d2e3b', '13', 'Von Wells', '20797', '(502)684-0068', '2.08', 'others', '1996-04-11T12:47:25.566', 'submitted', 'McClymonds');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('e6b32fac-5e9f-4252-8a61-03734c1c9be0', '32', 'Bode Throughway', '65920', '(529)277-8793', '811.86', ' renting tenant', '1993-01-10T02:06:47.844', 'approved', 'Mosswood');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('7056c42d-5fd9-40a1-8d38-f6a954196fd8', '49', 'Stephanie Overpass', '26642', '(261)477-5062', '896.81', ' renting tenant', '2004-06-12T09:43:36.473', 'rejected', 'Temescal');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('fcdc5996-2670-4269-ba75-20d4912294a5', '20', 'The Green', '09901', '(602)908-2147', '977.21', ' renting tenant', '1990-10-19T19:35:05.307', 'rejected', 'Ralph Bunche');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('634a7537-dc1c-4a33-9b73-8668699e5524', '22', 'Hill Road', '90945', '(859)543-7406', '887.55', ' concerned neighbor', '2020-05-21T07:48:03.260', 'pending', 'Oak Center');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('71d1f5df-d6d8-44ce-ab36-ce82c3b1054d', '46', 'W 1st Street', '24027', '(187)937-5748', '567.54', ' owner', '2002-01-11T11:08:18.586', 'rejected', 'Santa Fe');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('34bbc89f-9372-4c35-9ee4-5dbcdcf20cc2', '23', 'Harber Spurs', '63355', '(235)800-0127', '78.4', ' concerned neighbor', '1996-05-09T23:43:16.857', 'rejected', 'Bushrod');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('ce51b689-5c62-4d9a-bbd1-dcf035062bea', '42', 'Molly Fort', '00219', '(134)902-7578', '274.15', ' concerned neighbor', '2015-11-06T10:49:57.135', 'approved', 'Longfellow');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('3b680242-efd0-4069-b51e-6a9e9f0731d1', '43', 'Ash Grove', '60348', '(146)871-0395', '811.87', ' owner', '1997-10-09T15:39:48.493', 'approved', 'Temescal');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('08a73cad-f61d-4e89-9806-75ecddea449b', '42', 'Reichel Row', '18318', '(780)328-5730', '907.65', ' concerned neighbor', '2005-08-28T03:36:00.160', 'pending', 'Temescal');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('9fbf6a45-a354-4f20-8da7-28ac47f65110', '27', 'Arianna Ridge', '83959', '(322)515-2276', '756.69', ' renting tenant', '2021-08-15T23:01:53.429', 'submitted', 'Acron');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('658f1177-c9cf-4af7-86c2-ad841789d4f2', '14', 'Itzel Heights', '03660', '(234)604-6029', '6.34', ' concerned neighbor', '2012-08-12T19:03:49.052', 'submitted', 'South Prescott');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('6f9d7452-106b-4cc4-9c30-047f14fb3f9b', '50', 'Legros Isle', '48966', '(409)375-0766', '73.9', ' owner', '2025-02-25T01:08:01.019', 'rejected', 'Santa Fe');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('9a9b500f-d163-4a4a-a805-c84b22ddae49', '49', 'Lang Point', '68172', '(254)947-6210', '672.06', ' concerned neighbor', '2020-05-01T04:40:36.081', 'rejected', 'South Prescott');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('9a5866d9-0ce5-4fdf-8527-11fcccf750cf', '24', 'Paucek Pine', '96724', '(038)260-1453', '623.59', ' owner', '1995-02-08T04:24:41.831', 'approved', 'South Prescott');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('3964f6dc-da8c-486c-b2bb-37c0f56fe012', '41', 'Berenice Cape', '22446', '(805)028-9035', '519.67', ' renting tenant', '1996-07-26T19:50:36.303', 'rejected', 'Paradise Park');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('c2fc799c-1f7e-476b-bb78-178da9b48ff3', '37', 'E Washington Street', '45048', '(853)794-1502', '733.83', 'others', '2018-06-29T05:27:47.020', 'pending', 'Acron');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('94991b0b-7173-42cc-bf82-dc013bca55cb', '21', 'Emmerich Estates', '72005', '(005)515-5179', '586.57', 'others', '1997-06-21T19:02:02.895', 'rejected', 'Golden Gate');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('b10a741f-44ec-45c8-b3bc-757d40151f95', '50', 'Elnora Crossroad', '28899', '(084)092-0281', '626.58', 'others', '2008-11-30T16:01:12.334', 'approved', 'Piedmont Avenue');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('2bd76749-5fa6-4df5-a060-fec6b4fb5bf5', '46', 'E 1st Street', '52775', '(257)420-3818', '941.37', ' renting tenant', '2020-08-16T15:18:34.434', 'submitted', 'Mosswood');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('41f6c67f-822d-4a28-bca6-6ae7cb9ae0da', '15', 'Zander Causeway', '12920', '(507)009-7462', '183.49', ' concerned neighbor', '2018-06-13T17:43:20.068', 'approved', 'Acron');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('31fb4238-aa99-401a-9540-ffa888762d96', '20', 'Pollich Pass', '05540', '(707)107-2588', '43.93', ' renting tenant', '2016-12-15T09:07:46.538', 'submitted', 'Gaskill');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('13164434-7400-4eef-8a55-773e27f66f20', '42', 'Gibson Mill', '43943', '(133)320-8009', '162.64', ' concerned neighbor', '2018-05-20T02:18:00.973', 'rejected', 'Mosswood');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('b743050a-85e8-48a0-b859-a339cb2d16c2', '31', 'Ankunding Field', '72446', '(052)277-8160', '617.16', 'others', '1997-12-05T03:27:26.586', 'submitted', 'Temescal');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('3803349f-b674-406f-9a62-aff09a4cbb58', '16', 'S Lincoln Street', '34502', '(144)804-7866', '648.8', ' concerned neighbor', '2007-12-08T11:05:03.161', 'approved', 'Longfellow');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('8cc0e943-5e55-45a5-b94c-ec1807dd5845', '17', 'Zemlak Rapid', '43338', '(502)326-1068', '214.04', ' owner', '2023-06-23T23:22:00.964', 'approved', 'Temescal');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('65aa503c-c763-49d1-a805-181f5793ab6b', '39', 'Nitzsche Loaf', '81095', '(706)124-8817', '399.99', ' owner', '2021-07-07T04:23:01.801', 'pending', 'Fairview Park');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('c6a825d5-5939-4a83-b48d-04683d9e90e0', '22', 'Grove Road', '50368', '(172)388-5680', '640.71', 'others', '2009-10-09T16:51:03.588', 'submitted', 'Santa Fe');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('6dd4c425-7d1f-488d-8221-cf64d709e547', '24', 'Frances Trace', '28650', '(062)777-5621', '419.89', 'others', '2010-11-28T07:48:15.662', 'approved', 'Paradise Park');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('49fdcb30-76b5-4047-b991-c2224d3f2777', '50', '6th Avenue', '73369', '(342)807-7983', '944.77', ' renting tenant', '2015-07-29T18:30:11.848', 'pending', 'Mosswood');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('bb9c94cd-de22-4df2-b547-78717003f823', '19', 'Bridge Road', '16978', '(068)911-4809', '584.59', ' renting tenant', '2005-07-26T23:44:13.828', 'submitted', 'Golden Gate');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('e7ae076b-6193-41f1-9a50-a583e1e6a328', '48', 'Second Avenue', '19970', '(012)222-7068', '815.84', ' owner', '2016-04-27T17:28:07.140', 'pending', 'Acron');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('dbec48ef-e185-44d8-8622-d6b2307d3246', '14', 'S State Street', '34327', '(532)561-4597', '861.86', ' owner', '2010-08-05T19:56:26.958', 'pending', 'Piedmont Avenue');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('e775df57-5c72-4e1a-9ca3-44438894b34f', '23', 'Hawthorn Close', '68326', '(631)973-0797', '105.3', 'others', '2019-12-29T13:56:26.568', 'pending', 'Golden Gate');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('eddfae71-0431-4621-be29-a198b500211b', '32', 'Bergstrom Forks', '77216', '(700)497-4802', '641.64', ' owner', '2004-07-01T13:51:39.125', 'approved', 'Bushrod');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('03602695-fabc-4ded-bd55-ced85bc5930a', '33', 'Warren Close', '44245', '(620)208-1152', '61.28', 'others', '2004-11-03T04:04:04.795', 'approved', 'Mosswood');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('b2772341-60e9-4b6b-8247-7d82dec6b4b5', '49', 'Rudolph Parkways', '08427', '(579)225-2689', '543.69', 'others', '1990-04-16T22:07:23.482', 'rejected', 'Oak Center');
INSERT INTO treeRequests (referenceNum, rid, streetAddress, zipCode, phone, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, neighborhood) VALUES ('59822d24-729a-4e5d-8eed-e8e77898749e', '47', 'Lincoln Street', '74033', '(992)426-7795', '380.98', 'others', '2022-02-05T07:58:56.535', 'pending', 'McClymonds');

-- treePlanting test data
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('1', '03602695-fabc-4ded-bd55-ced85bc5930a', 'Handmade Plastic Pizza', '2011-06-20T14:35:53.776', 'Ressie Field', '85706', 'https://picsum.photos/seed/HoHVW6IB0/640/480', 'Lophostemon confertus', '5');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('2', '061f30bf-5df5-45f2-8e21-87dd9d1ed116', 'Handmade Steel Bike', '2018-02-24T09:52:05.478', 'Spruce Street', '79033', 'https://picsum.photos/seed/f2d97pPA/640/480', 'Afrocarpus gracilior', '2');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('3', '08a73cad-f61d-4e89-9806-75ecddea449b', 'Generic Steel Chair', '2006-03-03T19:20:21.205', 'Lizeth Prairie', '99581', 'https://loremflickr.com/640/480?lock=2779636824014848', 'Cedrus atlantica', '8');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('6', '13164434-7400-4eef-8a55-773e27f66f20', 'Incredible Metal Mouse', '2001-06-29T05:25:18.362', 'Lorenza Lakes', '18635', 'https://picsum.photos/seed/R4jTTg2l/640/480', 'Afrocarpus gracilior', '6');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('7', '1fef06e1-a710-4e05-b921-b84e40c41ea2', 'Refined Granite Tuna', '2023-04-19T05:16:22.095', 'Dangelo Bridge', '48781', 'https://picsum.photos/seed/tVP9f/640/480', 'Cedrus atlantica', '4');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('8', '25554ef2-9e30-4022-ad1a-3afdc1cb8098', 'Oriental Cotton Bike', '2023-12-01T00:37:13.523', 'Beechwood Avenue', '37689', 'https://loremflickr.com/640/480?lock=3046777930383360', 'Afrocarpus gracilior', '10');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('9', '2bd76749-5fa6-4df5-a060-fec6b4fb5bf5', 'Oriental Rubber Hat', '2025-02-14T13:02:51.052', 'Park Street', '75750', 'https://loremflickr.com/640/480?lock=191492471652352', 'Quercus boissieri', '10');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('10', '2e61bd4f-aed5-4981-9bb5-75a02de12d3e', 'Incredible Wooden Cheese', '2012-07-30T08:13:46.692', '8th Street', '08536', 'https://loremflickr.com/640/480?lock=7316458195386368', 'Cedrus atlantica', '5');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('11', '31fb4238-aa99-401a-9540-ffa888762d96', 'Rustic Fresh Shirt', '2007-09-30T23:13:59.015', 'The Drive', '70695', 'https://loremflickr.com/640/480?lock=3045405950476288', 'Cedrus atlantica', '4');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('12', '34bbc89f-9372-4c35-9ee4-5dbcdcf20cc2', 'Electronic Soft Cheese', '2022-06-02T15:50:43.068', 'Witting Cove', '92481', 'https://loremflickr.com/640/480?lock=3535149775978496', 'Afrocarpus gracilior', '7');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('13', '3803349f-b674-406f-9a62-aff09a4cbb58', 'Generic Concrete Fish', '2022-11-14T09:02:36.205', 'Julie Place', '52166', 'https://picsum.photos/seed/GuyrfIe/640/480', 'Lophostemon confertus', '7');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('14', '3964f6dc-da8c-486c-b2bb-37c0f56fe012', 'Handmade Soft Pizza', '1990-08-05T18:17:11.841', 'W Union Street', '42270', 'https://loremflickr.com/640/480?lock=4847744896204800', 'Afrocarpus gracilior', '1');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('15', '3b680242-efd0-4069-b51e-6a9e9f0731d1', 'Small Wooden Chicken', '2020-06-29T02:01:56.142', 'Stracke Ports', '01457', 'https://loremflickr.com/640/480?lock=2128468814856192', 'Cedrus atlantica', '5');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('16', '41f6c67f-822d-4a28-bca6-6ae7cb9ae0da', 'Gorgeous Steel Hat', '1997-03-08T13:28:36.762', 'Ray Manors', '08653', 'https://picsum.photos/seed/gsTyCPbEzo/640/480', 'Lophostemon confertus', '5');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('17', '49fdcb30-76b5-4047-b991-c2224d3f2777', 'Elegant Steel Chair', '2018-04-29T14:35:13.566', 'Colton Shore', '31577', 'https://picsum.photos/seed/R1zYE8ky/640/480', 'Quercus boissieri', '8');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('18', '59822d24-729a-4e5d-8eed-e8e77898749e', 'Modern Granite Ball', '2016-01-27T08:57:31.900', 'Kessler Pines', '64225', 'https://picsum.photos/seed/iqqNUw3cb4/640/480', 'Lophostemon confertus', '4');
INSERT INTO treePlantings (plantID, requestRefNum, eventName, plantDate, streetAddress, zipCode, photoAfter, treePlanted, aid) VALUES ('19', '634a7537-dc1c-4a33-9b73-8668699e5524', 'Fantastic Fresh Shoes', '2025-01-10T11:43:33.494', 'Wisoky Hill', '70980', 'https://picsum.photos/seed/bvz2FWEAX/640/480', 'Cedrus atlantica', '7');

-- volunteerPlants test data
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('18', '86', '5.2', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('8', '77', '4.4', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('1', '51', '0.9', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('1', '67', '3.6', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('1', '56', '1.6', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('12', '96', '2.5', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('19', '71', '0.4', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('2', '57', '3.9', 'light');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('19', '68', '4.2', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('2', '65', '3.6', 'light');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('15', '85', '0.5', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('3', '96', '2.5', 'light');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('14', '67', '2.7', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('10', '78', '2.7', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('10', '63', '0.2', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('19', '74', '0.4', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('8', '95', '3.9', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('7', '77', '5.6', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('6', '74', '4.8', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('13', '61', '4.4', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('13', '98', '5.9', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('17', '89', '1.5', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('11', '52', '3.7', 'light');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('6', '55', '1.7', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('14', '57', '1.9', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('7', '90', '5.7', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('9', '81', '5.9', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('15', '56', '4.3', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('13', '76', '2.9', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('14', '59', '4.2', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('12', '89', '1.9', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('2', '69', '5.8', 'light');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('3', '76', '4.5', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('8', '51', '1.4', 'light');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('8', '89', '3.7', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('19', '69', '5.4', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('12', '55', '2.2', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('14', '78', '0.5', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('10', '91', '6', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('15', '72', '2', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('7', '70', '3.9', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('14', '95', '5.2', 'light');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('1', '61', '4.3', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('15', '54', '4', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('8', '64', '4.3', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('3', '67', '2', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('7', '89', '0.1', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('2', '72', '2.1', 'light');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('2', '89', '2.3', 'heavy');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('10', '71', '5', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('1', '81', '4.6', 'overload');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('8', '75', '1', 'moderate');
INSERT INTO volunteerPlants (plantID, vid, workHour, feedback) VALUES ('3', '61', '0.2', 'moderate');

-- insertion for plantingZones (incomplete, ONGOING).
INSERT INTO plantingZones VALUES
                              (1, FALSE, FALSE, TRUE, TRUE),
                              (2, FALSE, TRUE, TRUE, FALSE),
                              (3, FALSE, FALSE, TRUE, FALSE),
                              (4, TRUE, TRUE, TRUE, FALSE),
                              (5, FALSE, FALSE, FALSE, TRUE),
                              (6, FALSE, TRUE, TRUE, TRUE);

-- insertion for trees (incomplete, ONGOING).
INSERT INTO trees (
    commonName, scientificName, height, width, minPlantingBedWidth,
    plantableUnderPowerLines, caNative, droughtTolerance, growthRate,
    foliageType, debris, rootDamagePotential, nurseryAvailability,
    visualAttraction, inventory, zoneID
)
VALUES
    ('African fern pine', 'Afrocarpus gracilior', '40-60\'', '25-35\'', 5, FALSE, FALSE, 'High', 'Moderate', 'Evergreen', 'Low', 'Moderate', 'High', 'Greenscreen', 10, 1),

    ('Aleppo oak', 'Quercus boissieri', '30-40\'', '30-50\'', 5, FALSE, FALSE, 'High', 'Moderate', 'Deciduous', 'Low acorn potential', 'Moderate', 'Low', 'Fall color', 11, 1),

    ('Atlas cedar', 'Cedrus atlantica', '60-100\'', '30-45\'', 6, FALSE, FALSE, 'Very high', 'Fast', 'Evergreen', 'Low', 'High', 'Low', 'Structure', 12, 1),

    ('Brisbane box', 'Lophostemon confertus', '40-60\'', '25-40\'', 5, FALSE, FALSE, 'Moderate', 'Moderate', 'Evergreen', 'Low', 'Moderate', 'High', 'Bark', 13, 2),

    ('Bronze loquat', 'Eriobotrya deflexa', '15-25\'', '20-30\'', 3, TRUE, FALSE, 'Moderate', 'Moderate', 'Evergreen', 'Moderate', 'Low', 'Moderate', 'Foliage, flowers', 14, 3),

    ('Cajeput tree', 'Melaleuca quinquenervia', '20-35\'', '15-35\'', 4, FALSE, FALSE, 'Very high', 'Moderate', 'Evergreen', 'Low', 'Moderate', 'High', 'Bark, flower', 15, 4),

    ('California buckeye', 'Aesculus californica', '20-30\'', '20-50\'', 8, TRUE, TRUE, 'High', 'Slow', 'Drought deciduous', 'Large seeds', 'Moderate', 'Moderate', 'Structure, fruit', 16, 5),

    ('Canary Island pine', 'Pinus canariensis', '60-100\'', '20-40\'', 8, FALSE, FALSE, 'Very high', 'Fast', 'Evergreen', 'Large cones, limb failure', 'High', 'High', 'Foliage, bark', 17, 6),

    ('Catalina cherry', 'Prunus lyonii', '15-30\'', '10-30\'', 8, TRUE, TRUE, 'High', 'Moderate', 'Evergreen', 'High fruit potential', 'Low', 'Moderate', 'Flower, foliage', 18, 1),

    ('Chestnut leaf oak', 'Quercus castaneifolia', '50-100\'', '30-60\'', 6, FALSE, FALSE, 'High', 'Very fast', 'Deciduous', 'High acorn potential', 'High', 'Low', 'Size, structure', 19, 1);


INSERT INTO siteVisits
(siteVisitID, siteVisitDate, visitStatus, streetAddress, powerLine, bedWidth, photoBefore, requestRefNum, aid)
VALUES
    (1, '2023-08-10', TRUE, 'N Central Avenue', TRUE, 5, 'https://picsum.photos/seed/sv1/640/480', '1fef06e1-a710-4e05-b921-b84e40c41ea2', 1),

    (2, '2022-05-15', FALSE, 'Hickle Roads', FALSE, 6, 'https://picsum.photos/seed/sv2/640/480', '061f30bf-5df5-45f2-8e21-87dd9d1ed116', 2),

    (3, '2023-11-25', TRUE, 'Silver Street', TRUE, 8, 'https://picsum.photos/seed/sv3/640/480', '25554ef2-9e30-4022-ad1a-3afdc1cb8098', 3),

    (4, '2021-03-14', FALSE, 'Buckingham Road', TRUE, 5, 'https://picsum.photos/seed/sv4/640/480', 'af63b711-b03c-4468-8096-b0055514eab7', 4),

    (5, '2020-09-18', TRUE, 'S Main Street', FALSE, 7, 'https://picsum.photos/seed/sv5/640/480', 'f161c5fe-82ba-4921-9026-e350a5f29e2c', 5),

    (6, '2024-01-02', TRUE, 'Leilani Alley', TRUE, 4, 'https://picsum.photos/seed/sv6/640/480', 'f9909b0b-2ae5-4435-b455-7c69d891e500', 6),

    (7, '2022-12-22', FALSE, 'Sibyl Ways', FALSE, 5, 'https://picsum.photos/seed/sv7/640/480', 'a6fd6eca-9e70-4fa8-ae8c-374032c6dd78', 7),

    (8, '2023-09-09', TRUE, 'Hillside Road', TRUE, 6, 'https://picsum.photos/seed/sv8/640/480', '0dacec47-6ccd-4a91-a673-5b709c3c6091', 1),

    (9, '2023-07-17', TRUE, 'Harley Circles', TRUE, 7, 'https://picsum.photos/seed/sv9/640/480', 'e75dc2b2-bcd9-443c-a59c-53a6dbcc44fd', 2),

    (10, '2022-10-03', FALSE, 'Post Road', FALSE, 5, 'https://picsum.photos/seed/sv10/640/480', '2e61bd4f-aed5-4981-9bb5-75a02de12d3e', 3);

INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (1, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (2, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (3, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (4, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (5, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (6, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (7, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (8, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (9, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (10, 1);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (1, 2);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (2, 2);
INSERT INTO oaktree.recommendedTrees (visitID, treeID) VALUES (1, 3);