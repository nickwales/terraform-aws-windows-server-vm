# Get latest Windows Server 2022 AMI
data "aws_ami" "windows-2019" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base*"]
  }
}

# Bootstrapping PowerShell Script
# data "template_file" "windows-userdata" {
#   template = <<EOF
# <powershell>
# # Rename Machine
# Rename-Computer -NewName "${var.windows_instance_name}" -Force;
# # Install IIS
# Install-WindowsFeature -name Web-Server -IncludeManagementTools;
# # Install Hyper-V
# Install-WindowsFeature -Name Hyper-V -IncludeManagementTools 
# # Install Docker
# # Set the TLS version used by the PowerShell client to TLS 1.2.
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
# Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
# Install-Package -Name docker -ProviderName DockerMsftProvider

# # Configure firewall rules
# netsh advfirewall set publicprofile state off

# # Install chocolatey and others
# [System.Net.ServicePointManager]::SecurityProtocol = 3072

# $NODE_NAME="${node_name}"
# $CONSUL_PATH="C:\${consul_folder}"
# $CONSUL_CONFIG_PATH="C:\${consul_folder}\${consul_config_folder}"
# $CONSUL_DATA_PATH="C:\${consul_folder}\data"
# $CONSUL_LOG_PATH="C:\${consul_folder}\consul.log"
# $CONSUL_CERTS_PATH="C:\${consul_folder}\${consul_certs_folder}"
# $ENVOY_PATH="C:\${envoy_folder}"
# $HASHICUPS_PATH="C:\${hashicups_folder}"
# $FAKESERVICE_PATH="C:\Fake"

# New-Item -type directory $CONSUL_PATH
# New-Item -type directory $CONSUL_CONFIG_PATH
# New-Item -type directory $CONSUL_CERTS_PATH
# New-Item -type directory $ENVOY_PATH
# New-Item -type directory $HASHICUPS_PATH
# New-Item -type directory $CONSUL_DATA_PATH
# New-Item -type directory $FAKESERVICE_PATH

# # Download Consul    
# cd $CONSUL_PATH
# Invoke-WebRequest -Uri ${consul_download_url} -OutFile consul.zip
# Expand-Archive consul.zip -DestinationPath . 

# # Download Envoy
# cd $ENVOY_PATH
# Invoke-WebRequest -Uri ${envoy_url} -OutFile envoy.exe

# # Add Consul and Envoy to path
# $env:path =  $env:path + ";" + $CONSUl_PATH + ";" + $ENVOY_PATH
# [System.Environment]::SetEnvironmentVariable('Path', $env:path,[System.EnvironmentVariableTarget]::User)
# [System.Environment]::SetEnvironmentVariable('Path', $env:path,[System.EnvironmentVariableTarget]::Machine)

# # Download the service definitions from KV store
# cd $CONSUL_CONFIG_PATH

# # Create Consul client configuration file
# @"
# ${config_file}
# "@ | Set-Content consul.json -Force

# # Restart machine
# Restart-Computer -Force
# </powershell>
# EOF
# }