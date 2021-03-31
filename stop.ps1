#!/usr/bin/env pwsh

# check if it's already running
$result = docker ps | Select-String "massif-visualizer-novnc"
if ($result) {
    $null = docker stop massif-visualizer-novnc
    $null = docker rm massif-visualizer-novnc
} else {
    Write-Output "Container was not running, use .\run.ps1 to start"
}