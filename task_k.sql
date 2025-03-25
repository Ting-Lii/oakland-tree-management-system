-- For each Oakland neighborhood, create a report that summarizes the requests, their progress (pending, in-process, completed, ec), the trees planted, etc.
SELECT
    tr.neighborhood,
    COUNT(tr.referenceNum) AS total_requests,
    SUM(CASE WHEN tr.requestStatus = 'submitted' THEN 1 ELSE 0 END) AS submitted,
    SUM(CASE WHEN tr.requestStatus = 'approved' THEN 1 ELSE 0 END) AS approved,
    SUM(CASE WHEN tr.requestStatus = 'pending' THEN 1 ELSE 0 END) AS pending,
    COUNT(tp.plantID) AS trees_planted
FROM treeRequests tr
LEFT JOIN treePlantings tp ON tr.referenceNum = tp.requestRefNum
GROUP BY tr.neighborhood;