-- Report: for the organization to understand the popularity of tree species
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