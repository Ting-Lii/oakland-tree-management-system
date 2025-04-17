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

-- sub query for report1(for checking purpose): select the district that has the highest planting work hours in total
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
);

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

-- subquery for report2: select the count of all tree species recommended for each neighborhood
SELECT n2.name AS neighborhood, COUNT(*) AS recommendCount, t2.commonName AS treeCommonName
    FROM recommendedTrees rt2
    INNER JOIN treeSpecies t2 ON rt2.treeID = t2.treeID
    INNER JOIN siteVisits sv2 ON rt2.requestID = sv2.requestID
    INNER JOIN treeRequests tr2 ON tr2.requestID = sv2.requestID
    INNER JOIN neighborhoods n2 ON n2.name = tr2.neighborhood
GROUP BY n2.name, rt2.treeID, treeCommonName
ORDER BY n2.name, recommendCount DESC, treeCommonName;