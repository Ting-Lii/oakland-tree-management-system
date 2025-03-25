SELECT tp.plantDate, tp.streetAddress, tp.zipCode, tr.neighborhood, tp.treePlanted
FROM treePlantings tp
JOIN treeRequests tr ON tp.requestRefNum = tr.referenceNum
WHERE tr.neighborhood IN ('Acron', 'Santa Fe', 'Oak Center', 'Bushrod')
   OR tp.zipCode IN ('93065', '59359')
ORDER BY tp.plantDate;