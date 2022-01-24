library(httr)
library(dplyr)
library(jsonlite)
library(stringr)
library(data.table)
library(RODBC)
options(scipen=999)

comment_db<- odbcConnect("comment_db")

comments <- data.table (
  sqlQuery(
    comment_db,"
    select * from [dbo].[comment_table]
    where comment like '%happy%'
    ")
)

comments$object_id <- NA
comment <- data.table(datetime=character(), message=character())
fbtoken <- ""

url <- paste0('https://...',comment[1],'?&access_token=',token)
response <- GET(url)
comments$object_id[1] <- content(response)$`creative`$`effective_object_story_id`
response$status_code

url_object <- paste0('https://...',ads$object_id[1],'/comments?status=true&access_token=',token)
response_object <- GET(url_object)

content(response_object)
comment <- rbind(comment,data.table(datetime=content(response_object)$`data`[[1]]$`created_time`,message=content(response_object)$`data`[[1]]$message))

comment$datetime[1] <- content(response_object)$`data`[[1]]$`created_time`

try(sqlDrop(comment_db, "dbo.comment_table", errors = TRUE))
sqlSave(comment_db, dat=comment, tablename = "dbo.comment_table", append = FALSE,
        rownames = FALSE, colnames = FALSE, verbose = FALSE,
        safer = TRUE, addPK = FALSE,
        fast = TRUE, test = FALSE, nastring = NULL)