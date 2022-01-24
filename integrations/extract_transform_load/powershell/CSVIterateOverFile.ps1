$path = "U:\Documents.csv"
$csv = Import-Csv -path $path

foreach($line in $csv)
{ 
    $properties = $line | Get-Member -MemberType Properties
    for($i=0; $i -lt $properties.Count;$i++)
    {
        $column = $properties[$i]
        $columnvalue = $line | Select -ExpandProperty $column.Name

        Write-Host $column.Name, $columnvalue

        # doSomething $column.Name $columnvalue 
        # doSomething $i $columnvalue 
    }
} 