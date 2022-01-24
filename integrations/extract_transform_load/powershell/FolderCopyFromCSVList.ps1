$Documents = Import-Csv "U:\DocumentList.csv" -Header Document
md D:\Documents
ForEach($lineItem in $Documents){Copy-Item -Path $lineItem.Document -Destination D:\Documents –Recurse}