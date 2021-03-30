param (
    [Parameter(Mandatory=$true)][string]$data_dir
)

# check if it's already running
$null = docker ps | findstr massif-visualizer-novnc
if ($?) {
	Write-Output "Container is already running, use .\stop.ps1 to stop it"
    exit 1
}

docker run -d --restart=always -v ${data_dir}:/data -p 127.0.0.1:8087:8080 --name=massif-visualizer-novnc tkreind/massif-visualizer-novnc:latest

# if there was an error quit silently
if (!$?) {
    exit 1
}

Write-Output "Hosting massif-visualizer with files from $data_dir at http://localhost:8087"
Write-Output "Run ./stop.sh to quit"

Start-Sleep -Seconds 2
Start-Process http://localhost:8087