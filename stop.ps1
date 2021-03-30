# check if it's already running
$null = docker ps | findstr massif-visualizer-novnc
if ($?) {
    $null = docker stop massif-visualizer-novnc
    $null = docker rm massif-visualizer-novnc
} else {
    Write-Output "Container was not running, use ./run.sh to start"
}