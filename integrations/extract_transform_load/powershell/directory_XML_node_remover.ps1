
# to remove a node from all xml-files in a directory and save result as a new xml-file

Get-ChildItem .\*.xml | % {
    [Xml]$xml = Get-Content $_.FullName
    $xml | Select-Xml -XPath '//*[local-name() = ''itemToRemove'']' | ForEach-Object{$_.Node.RemoveAll()}
    $xml.OuterXml | Out-File .\result.xml -encoding "UTF8"
} 