$SID = & ".\SIDget\GetSID.ps1"
Write-Host $SID

$filePath = Resolve-Path ".\AdobeSettings-main"
$regPath = "Registry::HKEY_USERS\$SID\SOFTWARE\Adobe\Acrobat Distiller\DC\AdobePDFOutputFolder"

Write-Host $regPath

#Set the folder for Adobe PDF Output Folder
if (-Not (Test-Path -Path $regPath))
{
    New-Item -Path "Registry::HKEY_USERS\$SID\SOFTWARE\Adobe\Acrobat Distiller\DC" -Name AdobePDFOutputFolder
}

Set-ItemProperty -Path $regPath -Name "(Default)" -Value 2
Set-ItemProperty -Path $regPath -Name "2" -Value "C:\Users\lab\Documents\Reports" -Force

#Set to not View Adobe PDF Results
$regPath2 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Printers\Adobe PDF\PrinterDriverData"
Set-ItemProperty -Path $regPath2 -Name ViewPrintOutput -Value 0