# aws-ssm-agent-install
Scripts to install AWS SSM Agent

## Windows Install

Open up PowerShell terminal as admin and run the following command:


```powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/grolston/aws-ssm-agent-install/master/install.ps1')
```


##  RHEL7/CENTOS7/AWSLinux2 Install

Run either curl or wget one-liners to install interactively:

curl
```sh
curl -fsS https://raw.githubusercontent.com/grolston/aws-ssm-agent-install/master/rhel-systemd-install.sh | sudo bash
```

wget
```sh
wget https://raw.githubusercontent.com/grolston/aws-ssm-agent-install/master/rhel-systemd-install.sh -O- | sudo bash
```
