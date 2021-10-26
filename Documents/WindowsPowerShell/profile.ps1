
$documents_path = [Environment]::GetFolderPath("MyDocuments")
. $documents_path/WindowsPowerShell/environments.ps1

# Modules.

# Colors in PowerShell.
# https://github.com/joonro/Get-ChildItemColor
# PowerShell module get-childitemcolor must be installed. Install like this:
# choco install get-childitemcolor
If (!(Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE

	Import-Module Get-ChildItemColor -ErrorAction SilentlyContinue

	if (!(Get-Module "Get-ChildItemColor")) {
		# Note that you need -AllowClobber option so Get-ChildItemColor may override the existing command Out-Default.
		Install-Module Get-ChildItemColor -AllowClobber # -Scope CurrentUser
		Import-Module Get-ChildItemColor
	}

	Set-Alias ll Get-ChildItem -option AllScope
	Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
	Set-Alias l Get-ChildItemColorFormatWide -option AllScope

	# Customize colors.
	$GetChildItemColorTable.File['Directory'] = "Magenta"
}

if ($host.Name -eq 'ConsoleHost') {
	# If you can't install the module. Just copy them from Johns-notebook directory
	# C:\Program Files\WindowsPowerShell\Modules\PSReadline to your homedir.
	Import-Module PSReadline

	# Disable Beep in terminal when erasing all text at the prompt with backspace.
	# https://superuser.com/questions/1113429/disable-powershell-beep-on-backspace
	Set-PSReadlineOption -BellStyle None
	
	# Set AutoComplete to work more like Bash.
	Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

	# Make Ctrl+D send exit just like in Bash.
	Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
}

# Chocolatey profile
$ChocolateyProfile = "$Env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Aliases. If you want to pass arguments to commands in aliases you need to 
# implement a function instead.
New-Alias vi vim
New-Alias sshl ssh.ps1
New-Alias cm chezmoi 

# Functions.
function vagrant { vagrant.exe --color $args }
function wsle { wsl /bin/sh -c ". ~/.environments && $args" }
. $documents_path\Scripts\Get-VMNetworkAdapterIP\Get-VMNetworkAdapterIP.ps1

# Make ps work more in the same way as on Unix.
Remove-Item alias:ps
function ps { Get-CimInstance Win32_Process | ft ProcessId, Name, HandleCount, WorkingSetSize, VirtualSize, CommandLine }

function .. { cd .. }
function ... { cd ..\.. }
function .... { cd ..\..\.. }

# Puppet development.
function pdk-lint { & pdk bundle exec puppet-lint --relative --fail-on-warnings --no-double_quoted_strings-check --no-80chars-check --no-variable_scope-check --no-quoted_booleans-check --no-140chars-check --no-inherits_across_namespaces-check --no-documentation-check --no-case_without_default-check --no-selector_inside_resource-check --no-parameter_order-check . }

# Variables:
# Should be number of this computers Etherned adapter that is used to access LAN. 
# Number is listen when you run command 'route print'.
# Used to configure route table to be able to still access LAN resources while
# connected with VPN'ns.
$env:LAN_ETH = 127

# Set the same prompt as on Linux.
# Based on: https://ss64.com/ps/syntax-prompt.html
function prompt {
	# Write home directory as ~ just like Bash.
	if ("$pwd" -eq "$Env:USERPROFILE") {
		$pwd_last_dir = '~'
	} else {
		$pwd_last_dir = $(($pwd -split '\\')[-1] -join '\')
	}
	
	$prompt = $Env:USERNAME + '@' + $pwd_last_dir + '$ '
	$host.ui.RawUI.WindowTitle = "PS $prompt"
	
	# To Print prompt with colors.
	# https://stackoverflow.com/questions/6297072/color-for-the-prompt-just-the-prompt-proper-in-cmd-exe-and-powershell
	Write-Host "$Env:USERNAME@" -NoNewLine -ForegroundColor White
	Write-Host "$pwd_last_dir" -NoNewLine -ForegroundColor Magenta
	Write-Host '$' -NoNewLine -ForegroundColor White
	return ' '
}

# Autosize text in Format-Table by default.
# https://gallery.technet.microsoft.com/scriptcenter/Change-Format-Table-7d49b047
$PSDefaultParameterValues["Format-Table:Autosize"]=$true

# Detect based on Current Working Directory if we should change to users home directory instead.
if (
		# If CWD is C:\WINDOWS\system32 or similar Powershell is probably started from explorer.exe.
		# This also happens when running it as Admin.
		(Get-Location).path -eq [System.Environment]::SystemDirectory -or
		# Is started from Brave browser using ssh:// links associated to CustomURL running Windows Terminal.
		# (Get-Location).path -like "$Env:LOCALAPPDATA\BraveSoftware\Brave-Browser\Application\*"
		(Get-Location).path -like "${Env:ProgramFiles(x86)}\BraveSoftware\Brave-Browser\Application\*"	) {
		Set-Location $Env:Userprofile
}

