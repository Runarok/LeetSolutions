-- Find all actor-director pairs with at least 3 collaborations
SELECT 
    actor_id, 
    director_id
FROM ActorDirector
-- Group by actor and director to count collaborations
GROUP BY actor_id, director_id
-- Only keep pairs with 3 or more collaborations
HAVING COUNT(*) >= 3;
