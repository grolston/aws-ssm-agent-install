$ErrorActionPreference = 'Stop'
## check admin
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    echo "You are not running as an Administrator. Please try again with admin privileges."
    exit 1
}
## Check service availability and Status
if(Get-Service AmazonSSMAgent -ErrorAction SilentlyContinue){
  echo "AmazonSSMAgent service already installed"
  if( (Get-Service AmazonSSMAgent).Status -EQ "Stopped" ) {
    echo "identified service not running...attempting to start"
    Start-Service AmazonSSMAgent -ErrorAction Stop
    echo "Service started"
  }
  ## service is running script should exit with success
  exit 0
}
## force TLS
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
$DownloadUrl = 'https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe'
$AgentFile = "$env:TEMP\SSMAgent_latest.exe"
iwr 'https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe' -OutFile $AgentFile -UseBasicParsing
Start-Process -FilePath $AgentFile -ArgumentList "/S" -Wait
## ensure service is running
if(Get-Service AmazonSSMAgent -ErrorAction SilentlyContinue){
  Restart-Service AmazonSSMAgent
  rm -Force $AgentFile
}
else{
 exit 1 
}
