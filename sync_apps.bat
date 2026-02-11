@echo off
echo Syncing PocketTools apps...
powershell -Command "$files = Get-ChildItem -Path 'docs/*.html' -Exclude 'index.html'; $apps = foreach ($f in $files) { $content = Get-Content $f.FullName -Raw -Encoding UTF8; if ($content -match '<title>(.*?)<\/title>') { $title = $Matches[1].Trim() } else { $title = $f.BaseName }; if ($content -match '<meta\s+name=[\""'']app-icon[\""'']\s+content=[\""''](.*?)[\""'']') { $icon = $Matches[1].Trim() } else { $icon = 'layout' }; [PSCustomObject]@{ name = $title; path = $f.Name; filename = $f.Name; icon = $icon } }; $json = $apps | ConvertTo-Json; $finalContent = '// This file is auto-generated. Do not edit manually.' + [System.Environment]::NewLine + 'const APPS_DATA = ' + $json + ';' ; [System.IO.File]::WriteAllText('docs/apps_data.js', $finalContent, [System.Text.Encoding]::UTF8); Write-Host 'Successfully synced ' $apps.Count ' apps (index.html excluded).'"
echo Done!
pause
