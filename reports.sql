-- 1. create a report about the volunteer average workload for the neighborhood
-- that has more than 1 tree planted and is in the highest total work hour district
-- including the average working hour, the total count of volunteer that gives a feedback of overload,
-- and the overload rate

SELECT tr.neighborhood,
       ROUND(AVG(vp.workHour), 2) AS AverageWorkingHour,
       COUNT(DISTINCT tp.requestID) AS treePlantedCount,
       SUM(vp.workloadFeedback = 'overload') AS OverloadCount,
       ROUND(SUM(vp.workloadFeedback = 'overload')/COUNT(*), 2) AS OverloadRate
FROM volunteerPlants vp INNER JOIN treePlantings tp ON vp.requestID = tp.requestID
    INNER JOIN treeRequests tr ON tr.requestID = tp.requestID
    INNER JOIN neighborhoods n ON tr.neighborhood = n.name
WHERE n.district = (
        SELECT n2.district
            FROM neighborhoods n2
            INNER JOIN treeRequests tr2 ON tr2.neighborhood = n2.name
            INNER JOIN treePlantings tp2 ON tr2.requestID = tp2.requestID
            INNER JOIN volunteerPlants vp2 ON vp2.requestID = tp2.requestID
        GROUP BY n2.district
        HAVING SUM(vp2.workHour) >= ALL(
            SELECT SUM(vp3.workHour)
                FROM neighborhoods n3
                INNER JOIN treeRequests tr3 ON tr3.neighborhood = n3.name
                INNER JOIN treePlantings tp3 ON tr3.requestID = tp3.requestID
                INNER JOIN volunteerPlants vp3 ON vp3.requestID = tp3.requestID
            GROUP BY n3.district
        )
    )
GROUP BY tr.neighborhood
HAVING COUNT(DISTINCT tp.requestID) > 1;

-- 2. create a report about the most recommended tree species(common name) for all the neighborhood
-- this might includes multiple tuples for one neighborhood because there might be equal number
-- of recommendations of different tree species per each neighborhood
SELECT n.name AS neighborhood, t2.commonName AS mostRecommendedTree
    FROM recommendedTrees rt2
    INNER JOIN treeSpecies t2 ON rt2.treeID = t2.treeID
    INNER JOIN siteVisits sv2 ON rt2.requestID = sv2.requestID
    INNER JOIN treeRequests tr2 ON tr2.requestID = sv2.requestID
    INNER JOIN neighborhoods n ON n.name = tr2.neighborhood
GROUP BY n.name, t2.commonName
HAVING COUNT(*) = (
    SELECT MAX(tree_count)
        FROM (
            SELECT n2.name AS neighborhood, rt3.treeID, COUNT(*) AS tree_count
                FROM recommendedTrees rt3
                INNER JOIN siteVisits sv3 ON rt3.requestID = sv3.requestID
                INNER JOIN treeRequests tr3 ON tr3.requestID = sv3.requestID
                INNER JOIN neighborhoods n2 ON n2.name = tr3.neighborhood
            GROUP BY n2.name, rt3.treeID
        ) AS subquery
    WHERE subquery.neighborhood = n.name
)
ORDER BY n.name;

-- Ting Li
-- 3. justification/motivation: we want to track tree species and volunteer number impact in actively planting neighborhood in a given year.
-- PS: we temporarily set given year is 2025. In app, user input a year.
-- Show the number of distinct tree species planted by neighborhood in a given year,
-- only for neighborhoods where total planting events that year exceeded 2,
-- including the number of volunteers involved in each neighborhood’s plantings.
SELECT n.name AS neighborhood, COUNT(DISTINCT tS.commonName) AS species_count, COUNT(DISTINCT vp.vid) AS total_volunteers
FROM treePlantings tp
    INNER JOIN treeRequests tr ON tp.requestID = tr.requestID
    INNER JOIN neighborhoods n ON tr.neighborhood = n.name
    INNER JOIN treeSpecies ts ON TRIM(LEADING ' ' FROM tp.treePlanted) = ts.treeID
    LEFT JOIN volunteerPlants vp ON vp.requestID = tp.requestID -- some tree planting might have no volunteer yet
WHERE YEAR(tp.plantDate) = 2025 AND tr.neighborhood IN (
    SELECT tr2.neighborhood
    FROM treePlantings tp2
        INNER JOIN treeRequests tr2 ON tp2.requestID = tr2.requestID
    WHERE YEAR(tp2.plantDate) = 2025
    GROUP BY tr2.neighborhood
    HAVING COUNT(tp2.treePlanted) >= 2
)
GROUP BY n.name;

-- Ting Li
-- 4. justification/motivation: To help city planners make better planting decisions by identifying drought-tolerant trees that are suitable for hash planting zones
-- (has factor “Under harsh sites: windy, dry or salty”) but were never been requested to be planted by residents in tree planted neighborhood over a given time period (here use 2022- 2024).
-- This helps close gaps in usage of drought tolerance trees to potentially save more water.
-- PS: we temporarily set given year range is between 2022 and 2025. In app, user input the year range.
SELECT ts.commonName AS treeCommonName, n.name AS neighborhood
FROM treeSpecies ts
         INNER JOIN treeToPlantingZones ttpz ON ts.treeID = ttpz.treeID
         INNER JOIN plantingZoneFactors pzf ON ttpz.plantingZoneFactor = pzf.factor
         INNER JOIN recommendedTrees rt ON rt.treeID = ts.treeID
         INNER JOIN siteVisits sv ON sv.requestID = rt.requestID
         INNER JOIN treeRequests tr ON tr.requestID = sv.requestID
         INNER JOIN neighborhoods n ON tr.neighborhood = n.name
WHERE pzf.factor = 'Under harsh sites: windy, dry or salty'
  AND NOT EXISTS (
    SELECT 1
    FROM treePlantings tp
             INNER JOIN treeRequests tr2 ON tp.requestID = tr2.requestID
    WHERE tp.treePlanted = ts.treeID
      AND tr2.neighborhood = n.name
      AND YEAR(tp.plantDate) BETWEEN 2022 AND 2025
)
GROUP BY ts.commonName, n.name;

-- Yunyu Guo
-- Part 1: For a neighborhood entered by the user, show the diversity of tree species planted in a given year,
-- including the minimum and maximum tree species, associated planting zone factors,
-- filtering the neighborhoods with at least 2 species planted in the given year.
SET @neighborhoodName = ?;
SET @startYear = ?;
SET @endYear = ?;
SET @plantingZoneFactor = ?;

SELECT
    tr.neighborhood,
    COUNT(DISTINCT ts.treeID) AS species_count,
    MIN(ts.commonName) AS min_species,
    MAX(ts.commonName) AS max_species,
    MIN(tp.plantDate) AS firstPlantDate,
    MAX(tp.plantDate) AS lastPlantDate,
    GROUP_CONCAT(DISTINCT tpz.plantingZoneFactor) AS planting_zone_factors, -- concatenate values from a group into a single string, separated by commas
    (SELECT COUNT(*)
     FROM treePlantings tp_sub
     -- WHERE YEAR(tp_sub.plantDate) BETWEEN 2023 AND 2025) AS total_plantings_all_neighborhoods,
     WHERE YEAR(tp_sub.plantDate) BETWEEN @startYear AND @endYear) AS total_plantings_all_neighborhoods,
    (SELECT COUNT(DISTINCT tp_sub.treePlanted)
     FROM treePlantings tp_sub
     WHERE YEAR(tp_sub.plantDate) BETWEEN @startYear AND @endYear) AS total_species_all_neighborhoods
    -- WHERE YEAR(tp_sub.plantDate) BETWEEN 2023 AND 2025) AS total_species_all_neighborhoods
FROM treeRequests tr
    JOIN treePlantings tp ON tr.requestID = tp.requestID
    JOIN treeSpecies ts ON tp.treePlanted = ts.treeID
    LEFT JOIN treeToPlantingZones tpz ON ts.treeID = tpz.treeID
-- WHERE tr.neighborhood = 'Bushrod'
WHERE tr.neighborhood = @neighborhoodName
  AND tr.neighborhood IN (
    SELECT DISTINCT tr2.neighborhood
    FROM treeRequests tr2
    JOIN treePlantings tp2 ON tr2.requestID = tp2.requestID
-- WHERE YEAR(tp2.plantDate) BETWEEN 2023 AND 2025
    WHERE YEAR(tp2.plantDate) BETWEEN @startYear AND @endYear
    GROUP BY tr2.neighborhood
    HAVING COUNT(DISTINCT tp2.treePlanted) >= 2
    )
-- AND YEAR(tp.plantDate) BETWEEN 2023  AND 2025
  AND YEAR(tp.plantDate) BETWEEN @startYear AND @endYear
GROUP BY tr.neighborhood

UNION

-- Part 2: filter neighborhoods with a specific planting zone factor entered by the user
SELECT
    tr.neighborhood,
    COUNT(DISTINCT ts.treeID) AS species_count,
    MIN(ts.commonName) AS min_species,
    MAX(ts.commonName) AS max_species,
    MIN(tp.plantDate) AS firstPlantingDate,
    MAX(tp.plantDate) AS lastPlantingDate,
    GROUP_CONCAT(DISTINCT tpz.plantingZoneFactor) AS planting_zone_factors,
    NULL AS total_plantings, -- Placeholder to match the first part of total number of tree plantings
    NULL AS total_species_all_neighborhoods
FROM treeRequests tr
JOIN treePlantings tp ON tr.requestID = tp.requestID
JOIN treeSpecies ts ON tp.treePlanted = ts.treeID
LEFT JOIN treeToPlantingZones tpz ON ts.treeID = tpz.treeID
-- WHERE tr.neighborhood = 'Bushrod'
WHERE tr.neighborhood = @neighborhoodName
    -- AND tpz.plantingZoneFactor = 'Highly urbanized zones'
    AND tpz.plantingZoneFactor = @plantingZoneFactor
    -- AND YEAR(tp.plantDate) BETWEEN 2023  AND 2025
    AND YEAR(tp.plantDate) BETWEEN @startYear AND @endYear
GROUP BY tr.neighborhood;
-- Score Your Query
-- Tables joined (1–2:0 points, ≥3:1 point)
-- Both parts of the query join 4 tables. Score: +1

-- Non-inner/natural join? (no:0 points, yes:1 point)
-- Both parts use LEFT JOIN. Score: +1

-- # of subqueries (0:0 points, 1:1 point, >2:2 points)
-- Part 1 contains 3 subquery in the SELECT and in the WHERE clause. Score: +2

-- # queries comprising result via union/intersect (0:0 points, ≥1:1 point)
-- The query uses UNION to combine the results of two SELECT statements. Score: +1

-- Aggregate function(s) and grouping rows? (no:0 points, yes:1 point)
-- Both parts use COUNT, MIN, MAX, GROUP_CONCAT and GROUP BY. Score: +1

-- # WHERE/HAVING conditions not for joins (≤1:0 points, >1:1 point)
-- Part 1 has WHERE condition (WHERE YEAR() BETWEEN) not related to join logic. Score: +1

-- Non-aggregation functions or expressions in SELECT/WHERE? (no:0 points, yes:1 point)
-- Both parts use the YEAR() function in the WHERE clause. Score: +1

-- Strong motivation/justification for the query in the domain? (no:0 points, yes:1 point)
-- The query summarizes a specific neighborhood within a date range, based on either having a certain planting tree species diversity (Part 1's subquery condition) or having used a specific planting zone factor (Part 2's condition).
-- This query can be used to analyze requirement for urban forestry or planning.
-- Score: +1

-- Total Score = 9 points







