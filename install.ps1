$ErrorActionPreference = 'Stop'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
$DownloadUrl = 'https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe'
$AgentFile = "$env:TEMP\SSMAgent_latest.exe"
iwr https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe -OutFile $AgentFile -UseBasicParsing

Start-Process -FilePath $AgentFile -ArgumentList "/S"
rm -Force $AgentFile

if(Get-Service AmazonSSMAgent -ErrorAction SilentlyContinue){
  Restart-Service AmazonSSMAgent
}else{
 exit 1 
}

