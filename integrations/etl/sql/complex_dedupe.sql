If OBJECT_ID('DATABASE.dbo.temp_combined') is not null DROP TABLE DATABASE.dbo.temp_combined
;
WITH X as (
    SELECT DISTINCT
        CAST(LEFT([dateHour], 8) as DATETIME) as [date],
        CAST((LEFT([dateHour], 8) + ' '+ RIGHT([dateHour],2) + ':' + [minute]) as DATETIME) as [date_time],
        CAST((RIGHT([dateHour],2) + ':' + [minute]) as TIME) as [time],
        Keyword as keyword,
        campaign = CASE WHEN SUBSTRING(campaign,1,5) = 'A - ' THEN SUBSTRING(campaign,6,len(campaign)-5)
                        WHEN SUBSTRING(campaign,1,5) = 'B - ' THEN SUBSTRING(campaign,6,len(campaign)-5)
                        WHEN SUBSTRING(campaign,1,5) = 'C - ' THEN SUBSTRING(campaign,6,len(campaign)-5)					   
                        WHEN SUBSTRING(campaign,1,5) = 'D - ' THEN SUBSTRING(campaign,6,len(campaign)-5)						   
                        WHEN SUBSTRING(campaign,1,5) = 'E - ' THEN SUBSTRING(campaign,6,len(campaign)-5)						   
                        WHEN SUBSTRING(campaign,1,5) = 'F - ' THEN SUBSTRING(campaign,6,len(campaign)-5)
                        ELSE campaign END,
        source_system_id = CASE WHEN internal = 'Other' THEN 2 ELSE 1 END,
        ROW_NUMBER() OVER(PARTITION BY CAST(LEFT([dateHour], 8) as DATETIME)
                            , CAST((LEFT([dateHour], 8) + ' '+ RIGHT([dateHour],2) + ':' + [minute]) as DATETIME)
                            , internal, keyword 
            ORDER BY CASE WHEN source_system_id like '%ga%' and source_system_id not like '%crc%' THEN 1 
                        WHEN source_system_id = '(display)' THEN 3 
                        ELSE 2 END, device, keyword) as row_num
    FROM [DATABASE].[dbo].[google_analytics] WITH (NOLOCK)
    )
    SELECT 	X.[date], X.[date_time], X.[time], X.keyword, X.source_system_id, X.campaign,
        ROW_NUMBER() OVER(PARTITION BY X.[date] ORDER BY X.[date_time] DESC) as RowNum
    INTO [DATABASE].dbo.temp_combined
    FROM X
    where row_num = 1