SELECT
    treePlanted AS tree_name,
    COUNT(*) AS amount,
    EXTRACT(YEAR FROM CURRENT_DATE) - MIN(EXTRACT(YEAR FROM plantDate)) AS years_since_first_planting
FROM treePlantings
GROUP BY treePlanted
ORDER BY amount DESC, tree_name;