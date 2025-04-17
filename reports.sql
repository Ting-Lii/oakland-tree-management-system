-- 1. create a report about the volunteer average workload for the neighborhood
-- that has more than 1 tree planted and is in the highest total work hour district
-- including the average working hour, the total count of volunteer that gives a feedback of overload,
-- and the overload rate

SELECT tr.neighborhood,
       ROUND(AVG(vp.workHour), 2) AS AverageWorkingHour,
       COUNT(tp.requestID) AS treePlantedCount,
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
HAVING COUNT(tp.requestID) > 1;

-- 2. create a report about the most recommended tree species(common name) for all the neighborhood
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

-- 3. justification/motivation: we want to track tree species and volunteer number impact in actively planting neighborhood.
-- PS: the current result is empty table as no valid row yet; we temporarily set given year is 2023.
-- Show the number of distinct tree species planted by neighborhood in a given year,
-- only for neighborhoods where total planting events that year exceeded 2,
-- including the number of volunteers involved in each neighborhood’s plantings.
-- time complexity:

SELECT n.name AS neighborhood, COUNT(DISTINCT t.commonName) AS species_count, COUNT(DISTINCT vp.vid) AS total_volunteers
FROM treePlantings tp
    JOIN treeRequests tr ON tp.requestRefNum = tr.referenceNum
    JOIN neighborhoods n ON tr.neighborhood = n.name
    JOIN trees t ON TRIM(LEADING ' ' FROM tp.treePlanted) = t.commonName
    LEFT JOIN volunteerPlants vp ON vp.plantID = tp.plantID -- some tree planting might have no volunteer
WHERE YEAR(tp.plantDate) = 2023 AND tr.neighborhood IN (
    SELECT tr2.neighborhood
    FROM treePlantings tp2
        JOIN treeRequests tr2 ON tp2.requestRefNum = tr2.referenceNum
    WHERE YEAR(tp2.plantDate) = 2023
    GROUP BY tr2.neighborhood
    HAVING COUNT(tp2.plantID) >= 2
)
GROUP BY n.name;


-- 4. justification/motivation: To help city planners make better planting decisions by identifying drought-tolerant trees that are suitable for hash planting zones
-- (e.g., windy, dry, or salty) but were never been requested to be planted by residents in any neighborhood over a specified time period.
-- This helps close gaps in usage of suitable trees.
-- time complexity:
SELECT t.commonName AS treeCommonName, n.name AS neighborhood
FROM plantingZones pz
    JOIN trees t ON pz.zoneID = t.zoneID
    JOIN recommendedTrees rt ON rt.treeID = t.treeID
    JOIN siteVisits sv ON sv.siteVisitID = rt.visitID
    JOIN treeRequests tr ON sv.requestRefNum = tr.referenceNum
    JOIN neighborhoods n ON n.name = tr.neighborhood
WHERE pz.hashSites = 1
AND NOT EXISTS (
    SELECT 1
    FROM treePlantings tp
        JOIN treeRequests tr2 ON tp.requestRefNum = tr2.referenceNum
    WHERE TRIM(LEADING ' ' FROM tp.treePlanted) = t.commonName
    AND tr2.neighborhood = n.name
    AND YEAR(tp.plantDate) BETWEEN 2022 AND 2024
)
GROUP BY t.commonName, n.name;

-- 5. Report: for the organization to understand the popularity of tree species
-- and the associated volunteer effort.

-- Query part 1: Report for species with recorded volunteer participation
SELECT
    tp.treePlanted AS species,
    -- Retrieve the neighborhood from the original tree request via a subquery
    MIN(tr.neighborhood) AS neighborhood,
    COUNT(tp.plantID) AS totalPlantings,
    AVG(vp.workHour) AS avgVolunteerHours,
    MIN(tp.plantDate) AS firstPlanting,
    MAX(tp.plantDate) AS lastPlanting
FROM treePlantings tp
JOIN volunteerPlants vp ON tp.plantID = vp.plantID
JOIN treeRequests tr ON tr.referenceNum = tp.requestRefNum
WHERE tp.treePlanted IS NOT NULL AND vp.workHour >= 0
GROUP BY tp.treePlanted
HAVING COUNT(tp.plantID) > 1 AND AVG(vp.workHour) > 1 -- HAVING: filters grouped results based on aggregate conditions. COUNT(`tp.plantID`) > 1: only groups (neighborhoods or users) with more than one tree planting record; AVG(`vp.workHour`) > 1 excludes groups whose volunteers contributed insignificantly.

UNION

-- Query part 2: Report for species with no volunteer participation recorded
SELECT
    tp.treePlanted AS species,
    MIN(tr.neighborhood) AS neighborhood,
    COUNT(tp.plantID) AS totalPlantings,
    0 AS avgVolunteerHours,
    MIN(tp.plantDate) AS firstPlanting,
    MAX(tp.plantDate) AS lastPlanting
FROM treePlantings tp
LEFT JOIN volunteerPlants vp ON tp.plantID = vp.plantID
JOIN treeRequests tr ON tr.referenceNum = tp.requestRefNum
WHERE vp.plantID IS NULL AND tp.treePlanted IS NOT NULL -- tree planting does not have associated volunteer
GROUP BY tp.treePlanted
HAVING COUNT(tp.plantID) > 0; -- only include species with at least one planting record