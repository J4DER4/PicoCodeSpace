<#
.SYNOPSIS
This is a brief description of what the code does.
installs a vpn client and sets up a remote desktop session all automated
.DESCRIPTION
This is a more detailed description of what the code does.

This program does the following:

Downloads a vpm client tailscale
Installs the tailscale client
Registers the node with the tailscale client
Sets up a list of remote desktop profiles
starts a remote desktop session

.PARAMETER ParameterName
This is a description of the parameter and its usage.

.PARAMETER Server = 100.85.76.130'
.PARAMETER User = 'LPP4'
.PARAMETER Password = 'xd'
.PARAMETER Tailscale_download link = 'https://pkgs.tailscale.com/stable/tailscale-setup-latest.exe'
.PARAMETER Authkey = 'tskey-auth-ktQzLE7CNTRL-8VJb2QTbXGMTjmsZ2rkPLMomCk6jiHfwa'

# Download address: https://pkgs.tailscale.com/stable/tailscale-setup-latest.exe
# Setup Tailscale: msiexec /i <path_to_tailscale_msi.msi>
# Register node: sudo tailscale up --authkey tskey-auth-ktQzLE7CNTRL-8VJb2QTbXGMTjmsZ2rkPLMomCk6jiHfwa
# Setup list for rdp: cmdkey /list | ForEach-Object{if($_ -like "*target=TERMSRV/*"){cmdkey /del:($_ -replace " ","" -replace "Target:","")}}
# Setup remote desktop profile: cmdkey /generic:TERMSRV/$Server /user:$User /pass:$Password
#Uninstall Tailscale: msiexec /x <path_to_tailscale_msi.msi>
mstsc /v:$Server
.EXAMPLE
Example usage of the code.
after parameters are set it can be run by executing the script in powershell
.NOTES
Any additional notes or information about the code.
#>

# Your code goes here

# Define parameters
$Server = '100.85.76.130'
$User = 'LPP4'
$Password = 'xd'
$TailscaleDownloadLink = 'https://pkgs.tailscale.com/stable/tailscale-setup-latest.exe'
$Authkey = 'tskey-auth-ktQzLE7CNTRL-8VJb2QTbXGMTjmsZ2rkPLMomCk6jiHfwa'

# Download Tailscale
Invoke-WebRequest -Uri $TailscaleDownloadLink -OutFile 'tailscale-setup-latest.exe'

# Install Tailscale
msiexec /i 'tailscale-setup-latest.exe'

# Register node with Tailscale
sudo tailscale up --authkey $Authkey

# Setup list for RDP
cmdkey /list | ForEach-Object {
    if($_ -like "*target=TERMSRV/*") {
        cmdkey /del:($_ -replace " ","" -replace "Target:","")
    }
}

# Setup remote desktop profile
cmdkey /generic:TERMSRV/$Server /user:$User /pass:$Password

# Start a remote desktop session
mstsc /v:$Server