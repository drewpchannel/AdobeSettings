Invoke-WebRequest https://github.com/drewpchannel/AdobeSettings/archive/refs/heads/main.zip -OutFile .\asa.zip
Expand-Archive .\asa.zip -Force

$SID = & ".\asa\AdobeSettings-main\SIDget\GetSID.ps1"

$regPath = "Registry::HKEY_USERS\$SID\SOFTWARE\Adobe\Acrobat Distiller\DC\AdobePDFOutputFolder"

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

$regPath3 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Printers\Adobe PDF\PrinterDriverData"
Set-ItemProperty -Path $regPath3 -Name AskToReplacePDF -Value 2