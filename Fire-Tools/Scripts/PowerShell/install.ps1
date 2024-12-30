# Download, Extract to AppData\Roaming, then Delete Fire-Tools.zip
Start-BitsTransfer -Source "https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.zip"
Expand-Archive -Path .\Fire-Tools.zip -Destination "$env:APPDATA" -Force
Remove-Item -Path .\Fire-Tools.zip

# Add Shortcut to Start Menu
$WshShell = New-Object -COMObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Fire Tools.lnk")
$Shortcut.TargetPath = "$env:APPDATA\Fire-Tools\main.py"
$Shortcut.WorkingDirectory = "$env:APPDATA\Fire-Tools"
$Shortcut.Save()

# Check / Install Python & Requirements
if (!(Select-String -Pattern "Python" -InputObject "$env:PATH" -Quiet)) {
    if (Get-Command winget) {
        winget install -s winget "Python.Python.3.12" --force
    } else {
        # Find Latest Python Version by Scraping Page & Install 
        $latest = (Invoke-WebRequest -Uri "https://www.python.org/downloads/").Links.href -like "*.exe"
        Start-BitsTransfer -Source "$latest" -Destination .\python-latest.exe
        .\python-latest.exe /passive PrependPath=1
        while (!(Get-Package -Name "*Python*" -ErrorAction SilentlyContinue)) {}
        Remove-Item -Path .\python-latest.exe
    }
    $python_path = Get-ChildItem "$env:LOCALAPPDATA\Programs\Python" -Include *Python* | Select-Object -Last 1
    Set-Item -Path Env:\PATH -Value ("$env:PATH;$python_path")
    [Environment]::SetEnvironmentVariable("Path","$env:PATH","User")
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/mrhaydendp/Fire-Tools/main/Fire-Tools/requirements.txt" -Destination "$env:APPDATA\Fire-Tools"
    pip install -r "$env:APPDATA\Fire-Tools\requirements.txt"
}

# Check / Install ADB (Download, Extract, Backup & Set Environment Variable)
if (!(Select-String -Pattern "platform-tools" -InputObject "$env:PATH" -Quiet)) {
    Start-BitsTransfer -Source "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
    Expand-Archive -Path .\platform-tools-latest-windows.zip -Destination "$HOME" -Force
    Remove-Item -Path .\platform-tools-latest-windows.zip
    [Environment]::SetEnvironmentVariable("PATH_BACKUP","$env:PATH","User")
    Set-Item -Path Env:\PATH -Value ("$env:PATH;$HOME\platform-tools")
    [Environment]::SetEnvironmentVariable("Path","$env:PATH","User")
}
