$folder_name = "ZabbixAgent"
$source = "https://s3.us-east-2.amazonaws.com/public-wmi-helper/ZabbixAgent.zip"
$destination = "C:\Program Files\"
$tempFile = "C:\ZabbixAgent.zip"

$zipFile = Invoke-WebRequest -Uri $source -UseBasicParsing
Set-Content -Path $tempFile -Encoding Byte -Value $zipFile.Content
Expand-Archive -Path $tempFile -DestinationPath $destination
Remove-Item $tempFile -Force
$config = $destination + $folder_name + "\zabbix_agentd.win.conf"

(Get-Content $config).Replace('{path}',$destination + $folder_name) | Out-File $config

$zabbix_agent = $destination + $folder_name + "\zabbix_agentd.exe"

# & $zabbix_agent --config $config --install
# & $zabbix_agent --start
