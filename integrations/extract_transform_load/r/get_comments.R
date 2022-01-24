library(httr)
library(dplyr)
library(jsonlite)
library(stringr)
library(data.table)
library(RODBC)
options(scipen=999)

CoreDB<- odbcConnect("CoreDB")
ads <- data.table (
  sqlQuery(
    CoreDB,"
    select * from [dbo].[comments]
    where name like '%cmp%'
    ")
)
ads$object_id <- NA
comment <- data.table(datetime=character(), message=character())
token <- ""

url <- paste0('https://api/v1/',ad_id[1],'?fields=creative.fields(effective_object_story_id)&access_token=',token)
response <- GET(url)
ads$object_id[1] <- content(response)$`creative`$`effective_object_story_id`
response$status_code

url_object <- paste0('https://api/v1/',ads$object_id[1],'/comments?status=true&access_token=',token)
response_object <- GET(url_object)

content(response_object)
comment <- rbind(comment,data.table(datetime=content(response_object)$`data`[[1]]$`created_time`,message=content(response_object)$`data`[[1]]$message))

comment$datetime[1] <- content(response_object)$`data`[[1]]$`created_time`