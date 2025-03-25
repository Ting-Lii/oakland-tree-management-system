-- justification/motivation: we want to track tree species and volunteer number impact in actively planting neighborhood.
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


-- justification/motivation: To help city planners make better planting decisions by identifying drought-tolerant trees that are suitable for hash planting zones
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
