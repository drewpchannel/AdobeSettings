#gets files beacuse intune will only send the script
Invoke-WebRequest https://github.com/drewpchannel/AdobeSettings/archive/refs/heads/main.zip -OutFile .\asa.zip
Expand-Archive .\asa.zip -Force

#gets the user idea from whoami /user
$SID = & ".\asa\AdobeSettings-main\SIDget\GetSID.ps1"

#Set the folder for Adobe PDF Output Folder, Intune reports errors without this
if (-Not (Test-Path -Path $regPath))
{
    New-Item -Path "Registry::HKEY_USERS\$SID\SOFTWARE\Adobe\Acrobat Distiller\DC" -Name AdobePDFOutputFolder
}

#Sets the default output folder
$regPath = "Registry::HKEY_USERS\$SID\SOFTWARE\Adobe\Acrobat Distiller\DC\AdobePDFOutputFolder"
Set-ItemProperty -Path $regPath -Name "(Default)" -Value 2
Set-ItemProperty -Path $regPath -Name "2" -Value "C:\Users\lab\Documents\Reports" -Force

#Set to not View Adobe PDF Results
$regPath2 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Printers\Adobe PDF\PrinterDriverData"
Set-ItemProperty -Path $regPath2 -Name ViewPrintOutput -Value 0

#Set to Never Replace pdf files
$regPath3 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Printers\Adobe PDF\PrinterDriverData"
Set-ItemProperty -Path $regPath3 -Name AskToReplacePDF -Value 2