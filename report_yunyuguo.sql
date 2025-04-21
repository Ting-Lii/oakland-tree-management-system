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



