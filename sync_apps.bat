@echo off
echo Syncing PocketTools apps...
powershell -Command "$files = Get-ChildItem -Path 'docs/*.html' -Exclude 'index.html'; $apps = foreach ($f in $files) { $content = Get-Content $f.FullName -Raw; if ($content -match '<title>(.*?)<\/title>') { $title = $Matches[1] } else { $title = $f.BaseName }; [PSCustomObject]@{ name = $title; path = $f.Name; filename = $f.Name } }; $json = $apps | ConvertTo-Json; $content = '// This file is auto-generated. Do not edit manually.`nconst APPS_DATA = ' + $json + ';' ; Set-Content -Path 'docs/apps_data.js' -Value $content; Write-Host 'Successfully synced ' $apps.Count ' apps (index.html excluded).'"
echo Done!
pause
