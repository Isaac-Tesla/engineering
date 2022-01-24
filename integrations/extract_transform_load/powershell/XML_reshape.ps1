#    imports
$sim_import = Import-Csv "U:\Doc1.csv"
$prices_import = Import-Csv "U:\Prices.csv"
$pages_import = Import-Csv "U:\Page_count.csv"

#    open XML document
[xml]$xml = Get-Content 'U:\original.xml'

#    remove "body" and "access" nodes
$xml.searchable.standard.body | %{ $_.parentnode.removechild($_) }
$xml.SelectNodes("//access") | %{ $_.parentnode.removechild($_) }

#    remove back (if exists)
$xml.SelectNodes("//back") | %{ $_.parentnode.removechild($_) }

#    insert product's meta information from a boilerplate XML file
[xml]$xml_boilerplate = Get-Content 'U:\boilerplate.xml'
$Child = $xml.SelectSingleNode('//db-meta')
$Child.ParentNode.InsertAfter($XML.ImportNode($xml_boilerplate.SelectSingleNode("//products-meta"), $true), $Child)

#    grab URI from document-uri
$URI = (Select-Xml -Xml $xml -XPath '/searchable/document-uri[@type="primary"]/text()').Node.Value
$URI = $URI.Replace("/source_files/00-", "").Replace("-primary.pdf", "")

#    rename file names to URI number in the appended product information
$xml.SelectNodes("//product-file") | % { 
    $_."#text" = $_."#text".Replace("XXXXXXXXXX", $URI) 
    }

#    collect created date from pub-date
$publishedDate = (Select-Xml -Xml $xml -XPath '/searchable/text()').Node.Value

#    update created date
$xml.SelectNodes("//product-date-created") | % { 
    $_."#text" = $_."#text".Replace("YYYY-MM-DD", $publishedDate) 
    }

#    collect sort-date from db-meta
$sortDate = (Select-Xml -Xml $xml -XPath '/searchable/date/text()').Node.Value

#    update last updated date
$xml.SelectNodes("//product-last-updated") | % { 
    $_."#text" = $_."#text".Replace("YYYY-MM-DD", $sortDate) 
    }

#    save output
$xml.Save("U:\output.xml")