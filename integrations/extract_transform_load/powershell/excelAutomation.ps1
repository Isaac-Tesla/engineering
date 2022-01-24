# start Excel
$excel = New-Object -comobject Excel.Application

#open file
$FilePath = 'U:\File.xlsm'
$workbook = $excel.Workbooks.Open($FilePath)

#make it visible (just to check what is happening)
$excel.Visible = $true

#access the Application object and run a macro
$app = $excel.Application
$app.Run("AutomatedWorkflow")