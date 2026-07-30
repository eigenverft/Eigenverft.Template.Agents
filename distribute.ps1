# Overlays agent instruction files from Eigenverft.Template.Agents into sibling repos.
# Copy-only (no deletes): project-specific files under AGENTS/RUNBOOK/ etc. stay unless
# the template ships the same relative path (then it overwrites).
# You run this script; it does not commit.

[CmdletBinding()]
param(
    [string]$WorkspaceRoot
)

if ([string]::IsNullOrWhiteSpace($WorkspaceRoot)) {
    $WorkspaceRoot = Split-Path -Path $PSScriptRoot -Parent
}

$WorkspaceRoot = [System.IO.Path]::GetFullPath($WorkspaceRoot)
if (-not (Test-Path -LiteralPath $WorkspaceRoot -PathType Container)) {
    throw "WorkspaceRoot does not exist or is not a directory: $WorkspaceRoot"
}
function Copy-GitTemplateSnapshot {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidatePattern('^https://')]
        [string]$RepositoryUrl,

        [Parameter(Mandatory)]
        [string[]]$DestinationPaths,

        [string[]]$Whitelist = @('*')
    )

    function Convert-GlobToRegex {
        param(
            [Parameter(Mandatory)]
            [string]$Pattern
        )

        $normalized = $Pattern.Replace('\', '/')

        $regex = [System.Text.StringBuilder]::new()
        $i = 0

        while ($i -lt $normalized.Length) {
            $ch = $normalized[$i]

            if ($ch -eq '*') {
                if (($i + 1) -lt $normalized.Length -and $normalized[$i + 1] -eq '*') {
                    [void]$regex.Append('.*')
                    $i += 2
                    continue
                }

                [void]$regex.Append('[^/]*')
                $i += 1
                continue
            }

            switch ($ch) {
                '?' { [void]$regex.Append('[^/]') }
                '.' { [void]$regex.Append('\.') }
                '\' { [void]$regex.Append('/') }
                '/' { [void]$regex.Append('/') }
                '(' { [void]$regex.Append('\(') }
                ')' { [void]$regex.Append('\)') }
                '[' { [void]$regex.Append('\[') }
                ']' { [void]$regex.Append('\]') }
                '{' { [void]$regex.Append('\{') }
                '}' { [void]$regex.Append('\}') }
                '+' { [void]$regex.Append('\+') }
                '^' { [void]$regex.Append('\^') }
                '$' { [void]$regex.Append('\$') }
                '|' { [void]$regex.Append('\|') }
                default { [void]$regex.Append($ch) }
            }

            $i += 1
        }

        return '^' + $regex.ToString() + '$'
    }

    function Test-WhitelistMatch {
        param(
            [Parameter(Mandatory)]
            [string]$RelativePath,

            [Parameter(Mandatory)]
            [string[]]$Patterns
        )

        $normalizedPath = $RelativePath.Replace('\', '/')

        foreach ($pattern in $Patterns) {
            $rx = Convert-GlobToRegex -Pattern $pattern
            if ($normalizedPath -imatch $rx) {
                return $true
            }
        }

        return $false
    }

    $destinations = @(
        $DestinationPaths |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ } |
            Select-Object -Unique
    )

    foreach ($destinationPath in $destinations) {
        if (-not [System.IO.Path]::IsPathRooted($destinationPath)) {
            throw "DestinationPath must be an absolute path: $destinationPath"
        }
    }

    $tempRoot  = Join-Path ([System.IO.Path]::GetTempPath()) ("git-template-" + [guid]::NewGuid().ToString("N"))
    $clonePath = Join-Path $tempRoot "repo"
    $results   = [System.Collections.Generic.List[object]]::new()

    try {
        New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null

        Write-Host "Cloning $RepositoryUrl ..."
        git clone --depth 1 $RepositoryUrl $clonePath
        if ($LASTEXITCODE -ne 0) {
            throw "git clone failed."
        }

        $cloneRootPrefix = $clonePath.TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar
        $gitDirPrefix = (Join-Path $clonePath '.git') + [System.IO.Path]::DirectorySeparatorChar

        $sourceFiles = @(
            Get-ChildItem -LiteralPath $clonePath -Recurse -File -Force |
                Where-Object { -not $_.FullName.StartsWith($gitDirPrefix, [System.StringComparison]::OrdinalIgnoreCase) } |
                ForEach-Object {
                    [pscustomobject]@{
                        FullName     = $_.FullName
                        RelativePath = $_.FullName.Substring($cloneRootPrefix.Length).Replace('\', '/')
                    }
                } |
                Where-Object { Test-WhitelistMatch -RelativePath $_.RelativePath -Patterns $Whitelist }
        )

        Write-Host ("Whitelisted files: {0}" -f $sourceFiles.Count)

        foreach ($destinationPath in $destinations) {
            if (-not (Test-Path -LiteralPath $destinationPath)) {
                Write-Warning "Skip missing destination: $destinationPath"
                continue
            }

            $copied = [System.Collections.Generic.List[string]]::new()
            New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null

            foreach ($source in $sourceFiles) {
                $destinationFile = Join-Path $destinationPath $source.RelativePath
                $destinationDir  = Split-Path -Path $destinationFile -Parent

                if (-not (Test-Path -LiteralPath $destinationDir)) {
                    New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
                }

                Copy-Item -LiteralPath $source.FullName -Destination $destinationFile -Force
                [void]$copied.Add($source.RelativePath)
            }

            Write-Host ("Copied {0} files -> {1}" -f $copied.Count, $destinationPath)
            [void]$results.Add([pscustomobject]@{
                Destination = $destinationPath
                CopiedCount = $copied.Count
                Files       = $copied
            })
        }

        return $results
    }
    finally {
        if (Test-Path -LiteralPath $tempRoot) {
            Remove-Item -LiteralPath $tempRoot -Recurse -Force
        }
    }
}

$templateUrl   = 'https://github.com/eigenverft/Eigenverft.Template.Agents.git'
$whitelist     = @( '.gitattributes', 'AGENTS.md', '.agents/**', 'AGENTS/**' )

# Repositories that must never receive the agent overlay.
$excludedDestinationNames = @(
    'Eigenverft.Template.Agents'
    'Eigenverft.Archive.All'
    'eigenverft'
)

# All active Eigenverft sibling repos that should share the agent overlay.
$destinationNames = @(
    'Eigenverft.App.AutomationWorkbench'
    'Eigenverft.App.BlazorMultihost'
    'Eigenverft.App.GlobalServerPwaHost'
    'Eigenverft.App.Lattice'
    'Eigenverft.NetLib.LlamaCpp'
    'Eigenverft.App.McpServer'
    'Eigenverft.App.ReverseProxy'
    'Eigenverft.Distributed.Drydock'
    'Eigenverft.Manifested.Agent'
    'Eigenverft.Manifested.Drydock'
    'Eigenverft.Manifested.Package'
    'Eigenverft.Manifested.Sandbox'
    'Eigenverft.Routed.RequestFilters'
    'Eigenverft.Windows.ProcessIsolationRestricted'
    'Eigenverft.Windows.ProcessIsolationSandbox'
)

$destinations = @(
    $destinationNames |
        Where-Object { $_ -notin $excludedDestinationNames } |
        ForEach-Object { Join-Path $workspaceRoot $_ }
)

Copy-GitTemplateSnapshot `
    -RepositoryUrl $templateUrl `
    -DestinationPaths $destinations `
    -Whitelist $whitelist
