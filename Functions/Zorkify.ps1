function Zorkify () {
    <#

        .SYNOPSIS

        A goofy script to return Zork quotes instead of actual errors or warnings

        .DESCRIPTION

        A goofy script to return Zork quotes instead of actual errors or warnings

        .PARAMETER Command

        Command/Script to run. Implemented with Invoke-Expression

        .INPUTS

        None

        .OUTPUTS

        $OutputFile

        .NOTES

        Version:        1.0

        Author:         Joshua Barton (@foobartn)

        Creation Date:  11.14.2016

        Purpose/Change: Initial script development
        
        .EXAMPLE

        Successful command

        Zorkify -Command 'Get-Process'

        .EXAMPLE

        Command with Write-Error output

        Zorkify -Command 'Write-Error "Nope"'

        .EXAMPLE

        Command with Write-Warning output

        Zorkify -Command 'Write-Warning "Nope"'

        .EXAMPLE

        Command with Throw output

        Zorkify -Command 'Throw "Nope"'

    #>


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