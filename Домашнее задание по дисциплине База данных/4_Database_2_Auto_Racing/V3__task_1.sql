WITH CarResults AS (
    SELECT 
        c.class, 
        r.car AS car_name, 
        AVG(r.position) AS average_position, 
        COUNT(r.race) AS race_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    GROUP BY c.class, r.car
),

RankedCars AS (
    SELECT 
        class, 
        car_name, 
        average_position, 
        race_count, 
        RANK() OVER (PARTITION BY class ORDER BY average_position) AS rank
    FROM CarResults
)

SELECT 
    car_name, 
    class AS car_class, 
    average_position, 
    race_count
FROM RankedCars
WHERE rank = 1
ORDER BY average_position;