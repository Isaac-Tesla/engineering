SELECT COUNT(*) as leads, SUM(spend) as spend
FROM [database].[dbo].[sales] 
WHERE OrderID IN
	(
		SELECT DISTINCT order_id COLLATE DATABASE_DEFAULT AS order_id 
		FROM database_2.report.google_analytics 
		WHERE product = 'insurance' and [date] >= '2010-01-01'
	)