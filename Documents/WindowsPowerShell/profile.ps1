
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
	# As of Get-ChildItemColor version 3.0.0 this no longer applies to Get-ChildItem.
	$GetChildItemColorTable.File['Directory'] = "Magenta"

	If ($PSVersionTable.PSEdition -eq 'Core') {

		# As of PowerShell version 7.2, PowerShell now has built-in support for colors.
		$PSStyle.FileInfo.Directory = "`e[95m" # Magenta.

		# Set Table and list color to Magenta.
		$PSStyle.Formatting.TableHeader = "`e[95m"
		$PSStyle.Formatting.FormatAccent = "`e[95m"
	}
}

if ($host.Name -eq 'ConsoleHost') {
	# If you can't install the module. Just copy them from Johns-notebook directory
	# C:\Program Files\WindowsPowerShell\Modules\PSReadline to your homedir.
	Import-Module PSReadline

	If ($PSVersionTable.PSEdition -eq 'Core') {
		# Set Auto-complete IntelliSense to list several options below the prompt.
		Set-PSReadLineOption -PredictionViewStyle ListView
	}

	# Disable Beep in terminal when erasing all text at the prompt with backspace.
	# https://superuser.com/questions/1113429/disable-powershell-beep-on-backspace
	Set-PSReadlineOption -BellStyle None
	
	# Set AutoComplete to work more like Bash.
	Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

	# Make Ctrl+D send exit just like in Bash.
	Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit

	# Disable command from being saved to history by starting the line with a space (' ' char).
	# Implements similar functionality as in bash. But unlike bash the command is availabe in the
	# current terminal's history but not available in a new terminal.
	# https://github.com/PowerShell/PSReadLine/issues/2698#issuecomment-886130377
	Set-PSReadLineOption -AddToHistoryHandler {
		param([string]$line)
		return $line.Length -gt 3 -and $line[0] -ne ' ' -and $line[0] -ne ';'
	}
}

# Git auto-completion module.
Import-Module posh-git -ErrorAction SilentlyContinue
# Install Git auto-completion if not already installed.
if (!(Get-Module "posh-git")) {
	Install-Module -Name posh-git -Scope CurrentUser -Force
	Import-Module posh-git
}

# Chocolatey profile
$ChocolateyProfile = "$Env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Rename default aliases.
if ($PSVersionTable.PSVersion -ge [Version]"6.0") {
	Remove-Alias h
}
Set-Alias hi Get-History


# Aliases. If you want to pass arguments to commands in aliases you need to 
# implement a function instead.
New-Alias vi nvim
New-Alias sshl ssh.ps1
New-Alias cm chezmoi 
New-Alias whereis Get-Command

# Make git alias work consistently in both Bash and PowerShell, without gl and gp PowerShell aliases
# blocking my git aliases.
New-Alias g git

# Functions.
function vagrant { vagrant.exe --color $args }
function wsle { wsl /bin/sh -c ". ~/.environments && $args" }
if (Test-Path("$documents_path\Scripts\Get-VMNetworkAdapterIP\Get-VMNetworkAdapterIP.ps1")) {
	. $documents_path\Scripts\Get-VMNetworkAdapterIP\Get-VMNetworkAdapterIP.ps1
}

# Make ps work more in the same way as on Unix.
Remove-Item alias:ps
function ps { Get-CimInstance Win32_Process | ft ProcessId, Name, HandleCount, WorkingSetSize, VirtualSize, CommandLine }

function .. { cd .. }
function ... { cd ..\.. }
function .... { cd ..\..\.. }

# Load extra modules (functions) in modules.d directory.
# Directory must exists.
$modules = gci "$documents_path\Scripts\modules.d\*.psm1"
foreach ( $module in $modules) {
	Import-Module $module
}

# Puppet development.
function pdk-lint { & pdk bundle exec puppet-lint --relative --fail-on-warnings --no-double_quoted_strings-check --no-80chars-check --no-variable_scope-check --no-quoted_booleans-check --no-140chars-check --no-inherits_across_namespaces-check --no-documentation-check --no-case_without_default-check --no-selector_inside_resource-check --no-parameter_order-check . }

# Variables:
if (Test-Path("$documents_path\Scripts\set_environment_for_network_devices.ps1")) {
	. $documents_path\Scripts\set_environment_for_network_devices.ps1
}

# Implement OSC 133.
# See https://learn.microsoft.com/en-us/windows/terminal/tutorials/shell-integration
# TODO: This doesn't work in PowerShell Core and Neovim Terminal when resizing the window.
$Global:__LastHistoryId = -1

function Global:__Terminal-Get-LastExitCode {
  if ($? -eq $True) {
    return 0
  }
  $LastHistoryEntry = $(Get-History -Count 1)
  $IsPowerShellError = $Error[0].InvocationInfo.HistoryId -eq $LastHistoryEntry.Id
  if ($IsPowerShellError) {
    return -1
  }
  return $LastExitCode
}

# Set the same prompt as on Linux.
# Based on: https://ss64.com/ps/syntax-prompt.html
function prompt {
	# To be compatible with both PowerShell Core and Windows PowerShell.
	$ESC = [char]27

	# Write home directory as ~ just like Bash.
	if ("$pwd" -eq "$Env:USERPROFILE") {
		$pwd_last_dir = '~'
	} else {
		$pwd_last_dir = $(($pwd -split '\\')[-1] -join '\')
	}
	
	$prompt = $Env:USERNAME + '@' + $pwd_last_dir + '$ '
	$host.ui.RawUI.WindowTitle = "PS $prompt"
	
	# First, emit a mark for the _end_ of the previous command.

	$gle = $(__Terminal-Get-LastExitCode);
	$LastHistoryEntry = $(Get-History -Count 1)
	# Skip finishing the command if the first command has not yet started
	if ($Global:__LastHistoryId -ne -1) {
		if ($LastHistoryEntry.Id -eq $Global:__LastHistoryId) {
			# Don't provide a command line or exit code if there was no history entry (eg. ctrl+c, enter on no command)
			$out += "$ESC]133;D`a"
		} else {
			$out += "$ESC]133;D;$gle`a"
		}
	}


	$loc = $($executionContext.SessionState.Path.CurrentLocation);

	# Prompt started
	$out += "$ESC]133;A$([char]07)";

	# CWD
	$out += "$ESC]9;9;`"$loc`"$([char]07)";

	# (your prompt here)
	# $out += "PWSH $loc$('>' * ($nestedPromptLevel + 1)) ";
	# To Print prompt with colors.
	# https://stackoverflow.com/questions/6297072/color-for-the-prompt-just-the-prompt-proper-in-cmd-exe-and-powershell
	# Source: ttps://superuser.com/a/1259916
	# Color codes: https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	$ESC = [char]27
	$out += "$ESC[0m$ESC[1m$ESC[39m$Env:USERNAME@$ESC[35m$pwd_last_dir$ESC[39m$ESC[0m$ " 

	# Prompt ended, Command started
	$out += "$ESC]133;B$([char]07)";

	$Global:__LastHistoryId = $LastHistoryEntry.Id

	return $out
}

# Autosize text in Format-Table by default.
# https://gallery.technet.microsoft.com/scriptcenter/Change-Format-Table-7d49b047
$PSDefaultParameterValues["Format-Table:Autosize"] = $true

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

