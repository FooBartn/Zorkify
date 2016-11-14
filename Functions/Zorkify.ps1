function Zorkify () {

    param (
        [parameter(Mandatory=$true)]
        [string]$Command
    )

    try {
        $CommandParams = @{
            Command = $Command
            ErrorVariable = 'CommandErrors'
            WarningVariable = 'CommandWarnings'            
        }

	    $CommandData = Invoke-Expression @CommandParams  2>$null 3>$null

        foreach ($CommandError in $CommandErrors) {
            $NonTermErrorMsg = $Results.NonTermError | Get-Random
            Write-Error $NonTermErrorMsg
        }

        foreach ($CommandWarning in $CommandWarnings) {
            $WarningMsg = $Results.Warning | Get-Random
            Write-Warning $WarningMsg
        }

        $CommandData

        if (
            $CommandErrors.Count -eq 0 -and
            $CommandWarnings.Count -eq 0
        ) {
            $SuccessMsg = $Results.Success | Get-Random
            Write-Host "
            
            $SuccessMsg" -ForegroundColor Green
        }
    } catch {
        $TermErrorMsg = $Results.TermError | Get-Random
        Throw $TermErrorMsg
    }
}