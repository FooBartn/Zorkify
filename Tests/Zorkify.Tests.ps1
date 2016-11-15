if(-not $ENV:BHProjectPath){
    Set-BuildEnvironment -Path $PSScriptRoot\..
}
Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue
Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force

Describe -Name 'Zorkify' {
    Context -Name 'Output Script ZorkOut.ps1' {
        $ScriptPath = Join-Path -Path $ENV:BHProjectPath -ChildPath 'Scripts\ZorkOut.ps1'

        It 'Should exist' {
            $ScriptPath | Should Exist
        }

        # Source ZorkOut.ps1
        . $ScriptPath

        It 'Should be formatted correctly' {
            $Results.Keys.Count | Should Be 4
            $Results.Keys | Should Match 'Success|Warning|NonTermError|TermError'
            $Results.Success | Should Not BeNullOrEmpty
            $Results.Warning | Should Not BeNullOrEmpty
            $Results.NonTermError | Should Not BeNullOrEmpty
            $Results.TermError | Should Not BeNullOrEmpty
        }
    }
}