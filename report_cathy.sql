-- 1. create a report about the volunteer average workload for the neighborhood
-- that has more than 1 tree planted and is in the highest total work hour district
-- including the average working hour, the total count of volunteer that gives a feedback of overload,
-- and the overload rate

SELECT tr.neighborhood,
       ROUND(AVG(vp.workHour), 2) AS AverageWorkingHour,
       COUNT(tp.plantID) AS treePlantedCount,
       SUM(vp.feedback = 'overload') AS OverloadCount,
       ROUND(SUM(vp.feedback = 'overload')/COUNT(*), 2) AS OverloadRate
FROM volunteerPlants vp INNER JOIN treePlantings tp ON vp.plantID = tp.plantID
    INNER JOIN treeRequests tr ON tr.referenceNum = tp.requestRefNum
    INNER JOIN neighborhoods n ON tr.neighborhood = n.name
WHERE n.district = (
        SELECT n2.district
            FROM neighborhoods n2
            INNER JOIN treeRequests tr2 ON tr2.neighborhood = n2.name
            INNER JOIN treePlantings tp2 ON tr2.referenceNum = tp2.requestRefNum
            INNER JOIN volunteerPlants vp2 ON vp2.plantID = tp2.plantID
        GROUP BY n2.district
        HAVING SUM(vp2.workHour) >= ALL(
            SELECT SUM(vp3.workHour)
                FROM neighborhoods n3
                INNER JOIN treeRequests tr3 ON tr3.neighborhood = n3.name
                INNER JOIN treePlantings tp3 ON tr3.referenceNum = tp3.requestRefNum
                INNER JOIN volunteerPlants vp3 ON vp3.plantID = tp3.plantID
            GROUP BY n3.district
        )
    )
GROUP BY tr.neighborhood
HAVING COUNT(tp.plantID) > 1;

-- 2. create a report about the most recommended tree species(common name) for all the neighborhood
SELECT n.name AS neighborhood, t2.commonName AS mostRecommendedTree
    FROM recommendedTrees rt2
    INNER JOIN trees t2 ON rt2.treeID = t2.treeID
    INNER JOIN siteVisits sv2 ON rt2.visitID = sv2.siteVisitID
    INNER JOIN treeRequests tr2 ON tr2.referenceNum = sv2.requestRefNum
    INNER JOIN neighborhoods n ON n.name = tr2.neighborhood
GROUP BY n.name, t2.commonName
HAVING COUNT(*) = (
    SELECT MAX(tree_count)
        FROM (
            SELECT n2.name AS neighborhood, rt3.treeID, COUNT(*) AS tree_count
                FROM recommendedTrees rt3
                INNER JOIN siteVisits sv3 ON rt3.visitID = sv3.siteVisitID
                INNER JOIN treeRequests tr3 ON tr3.referenceNum = sv3.requestRefNum
                INNER JOIN neighborhoods n2 ON n2.name = tr3.neighborhood
            GROUP BY n2.name, rt3.treeID
        ) AS subquery
    WHERE subquery.neighborhood = n.name
);