-- For every species of trees, find the number of trees planted and:
-- the number of years since the first tree of the species was planted, the number of years since the most recent tree of the species was planted.
SELECT
    treePlanted AS species,
    COUNT(*) AS amount,
    EXTRACT(YEAR FROM CURRENT_DATE) - MIN(EXTRACT(YEAR FROM plantDate)) AS years_since_first_planting,
    EXTRACT(YEAR FROM CURRENT_DATE) - MAX(EXTRACT(YEAR FROM plantDate)) AS years_since_last_planting
FROM treePlantings
GROUP BY species
ORDER BY amount DESC, species;

-- the year that had the most trees of the species planted and the number of trees planted.
SELECT t.treePlanted AS species, COUNT(*) AS total_planted,
    (
        SELECT EXTRACT(YEAR FROM plantDate)
        FROM treePlantings t_sub
        WHERE t_sub.treePlanted = t.treePlanted
        GROUP BY EXTRACT(YEAR FROM plantDate)
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS year_with_most,
    (
        SELECT COUNT(*)
        FROM treePlantings t_sub2
        WHERE t_sub2.treePlanted = t.treePlanted
        GROUP BY EXTRACT(YEAR FROM plantDate) -- aggregates all rows that occurred within the same year
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS num_planted_in_year
FROM treePlantings t
GROUP BY t.treePlanted;


