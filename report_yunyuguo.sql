-- Yunyu Guo
-- Part 1: For a neighborhood entered by the user, show the popularity of tree species planted in a given year,
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
    GROUP_CONCAT(DISTINCT tpz.plantingZoneFactor) AS planting_zone_factors -- concatenate values from a group into a single string, separated by commas
From treeRequests tr
JOIN treePlantings tp ON tr.requestID = tp.requestID
JOIN treeSpecies ts ON tp.treePlanted = ts.treeID
LEFT JOIN treeToPlantingZones tpz ON ts.treeID = tpz.treeID
-- WHERE tr.neighborhood = 'Bushrod'
WHERE tr.neighborhood = @neighborhoodName
    AND tr.neighborhood IN (
        SELECT DISTINCT tr2.neighborhood
        FROM treeRequests tr2
        JOIN treePlantings tp2 ON tr2.requestID = tp2.requestID
        WHERE YEAR(tp2.plantDate) BETWEEN 2023 AND 2025
        -- WHERE YEAR(tp2.plantDate) BETWEEN @startYear AND @endYear
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
    GROUP_CONCAT(DISTINCT tpz.plantingZoneFactor) AS planting_zone_factors
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




