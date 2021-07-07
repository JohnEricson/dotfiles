# Environment definitions. 
# Loaded by Documents/PowerShell/profile.ps1.

# Ensures Windows PowerShell modules are also available for PowerShell Core.
# This only adds the path if it doesn't already exists in PSModulePath.
$env:PSModulePath = $env:PSModulePath + "$([System.IO.Path]::PathSeparator)$($env:ProgramFiles)\WindowsPowerShell\Modules"

