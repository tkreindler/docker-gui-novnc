#!/usr/bin/env pwsh

param (
    [Parameter(Mandatory=$true)][string]$DataDirectory
)

# check if it's already running
$result = docker ps | Select-String "massif-visualizer-novnc"
if ($result) {
	Write-Output "Container is already running, use .\stop.ps1 to stop it"
    exit 1
}

docker run -d --restart=always -v ${DataDirectory}:/data -p 127.0.0.1:8087:8080 --name=massif-visualizer-novnc tkreind/massif-visualizer-novnc:latest

# if there was an error quit silently
if (!$?) {
    exit 1
}

Write-Output "Hosting Hosting massif-visualizer with files from $DataDirectory at http://localhost:8087"
Write-Output "Run .\stop.ps1 to quit"

Start-Sleep -Seconds 2
Start-Process http://localhost:8087