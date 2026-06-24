WITH CTE AS (
  SELECT 
    merchant_id, 
    credit_card_id, 
    amount, 
    transaction_timestamp,
    LAG(transaction_timestamp) OVER(
      PARTITION BY merchant_id, credit_card_id, amount 
      ORDER BY transaction_timestamp
    ) AS previous_timestamp
  FROM transactions
)

SELECT COUNT(*) AS payment_count
FROM CTE
WHERE EXTRACT(EPOCH FROM (transaction_timestamp - previous_timestamp)) / 60 <= 10;