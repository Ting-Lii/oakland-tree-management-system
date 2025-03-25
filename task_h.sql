SELECT
    tr.referenceNum,
    tr.streetAddress,
    tr.requestStatus,
    tr.dateSubmitted,
    DATEDIFF(CURRENT_DATE, tr.dateSubmitted) as days_since_submission
FROM treeRequests tr
LEFT JOIN treePlantings tp ON tr.referenceNum = tp.requestRefNum
WHERE tp.plantID IS NULL
AND tr.requestStatus NOT IN ('rejected')
ORDER BY tr.dateSubmitted ASC;