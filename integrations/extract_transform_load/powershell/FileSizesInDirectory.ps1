get-childitem D:\TEMP\Original -rec | where {!$_.PSIsContainer} |
select-object FullName, LastWriteTime, Length | export-csv -notypeinformation -delimiter '|' -path U:\file.csv