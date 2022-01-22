SELECT * 
INTO #deduped_lookup   
FROM (
    SELECT ROW_NUMBER() OVER (PARTITION BY brand, campaign_id, adset_id, ad_id ORDER BY ad_id  ) row_num, *
    FROM #lookup_table
) as A WHERE row_num = 1