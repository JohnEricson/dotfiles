# Outputs a line of a ServiceController
function Write-Color-Service
{
    param ([string]$Color = "White", $service)

    Write-host ("{0,-8}" -f $_.Status) -ForegroundColor $Color -noNewLine
    Write-host (" {0,-18} {1,-39}" -f (CutString $_.Name 18), (CutString $_.DisplayName 38)) -ForegroundColor "white"
}

function ServiceController {
    param (
        [Parameter(Mandatory=$True,Position=1)]
        $Service
    )

    if($script:showHeader)
    {
       Write-Host
       Write-Host "Status   Name               DisplayName"
       $script:showHeader=$false
    }

    if ($Service.Status -eq 'Stopped')
    {
        Write-Color-Service $Global:GetChildItemColorTable.Service["Stopped"] $Service
    }
    elseif ($Service.Status -eq 'Running')
    {
        Write-Color-Service $Global:GetChildItemColorTable.Service["Running"] $Service
    }
    else {
        Write-Color-Service $Global:GetChildItemColorTable.Service["Default"] $Service
    }
}
