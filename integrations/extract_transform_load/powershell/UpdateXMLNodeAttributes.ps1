

$string = 'U:\original.xml'
[xml]$xml = Get-Content $string  

#    Update the attributes

$nodes = $xml.SelectNodes("//searchable/binary-document-uri");
$counter = 0

foreach($node in $nodes) {
    $node.SetAttribute("mime-type", "application/pdf");   
    if($counter -eq 0){$node.SetAttribute("usage", "Web");}
    if($counter -eq 1){$node.SetAttribute("usage", "Print");}
    $node.SetAttribute("notes", "");
    $counter = 1
}

#$xml.searchable["binary-document-uri"].SetAttribute("mime-type", "application/pdf")
#$xml.searchable["binary-document-uri"].SetAttribute("usage", "Web")
#$xml.searchable["binary-document-uri"].SetAttribute("notes", "")

$outputString = "U:\test.xml"
$xml.Save($outputString)