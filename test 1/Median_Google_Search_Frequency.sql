WITH cte1 AS (
    SELECT
        searches,
        num_users,
        SUM(num_users) over (ORDER BY searches) AS cum_users,
        SUM(num_users) over() AS total_users
    FROM search_frequency
)

SELECT round(avg(searches),1) as median FROM cte1
where ((total_users)/2.0)+1
          BETWEEN cum_users-num_users+1 AND cum_users
   or (total_users)/2.0
          BETWEEN cum_users-num_users+1 AND cum_users;