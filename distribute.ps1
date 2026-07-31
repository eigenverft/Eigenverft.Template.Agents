# Overlays agent instruction files from Eigenverft.Template.Agents into sibling repos.
# Copy-only (no deletes): project-specific files under AGENTS/RUNBOOK/ etc. stay unless
# the template ships the same relative path (then it overwrites).
# Only missing or content-different template files are copied.
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

# PowerShell 5.1-compatible enum-like status values.
$DistributionStatus = [ordered]@{
    Distributed       = 'Distributed'
    UpToDate          = 'UpToDate'
    Missing           = 'Missing'
    CopyFailed        = 'CopyFailed'
    Candidate         = 'Candidate'
    ExplicitlyIgnored = 'ExplicitlyIgnored'
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

    function Test-FileContentEqual {
        param(
            [Parameter(Mandatory)]
            [string]$SourcePath,

            [Parameter(Mandatory)]
            [string]$DestinationPath
        )

        if (-not (Test-Path -LiteralPath $DestinationPath -PathType Leaf)) {
            return $false
        }

        $sourceInfo = Get-Item -LiteralPath $SourcePath -ErrorAction Stop
        $destinationInfo = Get-Item -LiteralPath $DestinationPath -ErrorAction Stop
        if ($sourceInfo.Length -ne $destinationInfo.Length) {
            return $false
        }

        $sourceHash = (Get-FileHash -LiteralPath $SourcePath -Algorithm SHA256 -ErrorAction Stop).Hash
        $destinationHash = (Get-FileHash -LiteralPath $DestinationPath -Algorithm SHA256 -ErrorAction Stop).Hash
        return $sourceHash -eq $destinationHash
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
        New-Item -ItemType Directory -Path $tempRoot -Force -ErrorAction Stop | Out-Null

        Write-Host "Cloning $RepositoryUrl ..."
        git clone --depth 1 $RepositoryUrl $clonePath
        if ($LASTEXITCODE -ne 0) {
            throw "git clone failed with exit code $LASTEXITCODE."
        }

        $cloneRootPrefix = $clonePath.TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar
        $gitDirPrefix = (Join-Path $clonePath '.git') + [System.IO.Path]::DirectorySeparatorChar

        $sourceFiles = @(
            Get-ChildItem -LiteralPath $clonePath -Recurse -File -Force -ErrorAction Stop |
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
            $projectName = Split-Path -Path $destinationPath -Leaf

            if (-not (Test-Path -LiteralPath $destinationPath -PathType Container)) {
                Write-Warning "Skip missing destination: $destinationPath"
                [void]$results.Add([pscustomobject][ordered]@{
                    Status       = $DistributionStatus.Missing
                    Project      = $projectName
                    Destination  = $destinationPath
                    ChangedCount = 0
                    ChangedFiles = @()
                    Details      = 'Configured destination is not available locally'
                })
                continue
            }

            $changedFiles = [System.Collections.Generic.List[string]]::new()

            try {
                foreach ($source in $sourceFiles) {
                    $destinationFile = Join-Path $destinationPath $source.RelativePath
                    if (Test-FileContentEqual -SourcePath $source.FullName -DestinationPath $destinationFile) {
                        continue
                    }

                    $destinationDir = Split-Path -Path $destinationFile -Parent
                    if (-not (Test-Path -LiteralPath $destinationDir -PathType Container)) {
                        New-Item -ItemType Directory -Path $destinationDir -Force -ErrorAction Stop | Out-Null
                    }

                    Copy-Item -LiteralPath $source.FullName -Destination $destinationFile -Force -ErrorAction Stop
                    [void]$changedFiles.Add($source.RelativePath)
                }

                if ($changedFiles.Count -eq 0) {
                    Write-Host ("Already up to date -> {0}" -f $destinationPath)
                    [void]$results.Add([pscustomobject][ordered]@{
                        Status       = $DistributionStatus.UpToDate
                        Project      = $projectName
                        Destination  = $destinationPath
                        ChangedCount = 0
                        ChangedFiles = @()
                        Details      = 'Template files already match the current version'
                    })
                }
                else {
                    Write-Host ("Distributed {0} changed files -> {1}" -f $changedFiles.Count, $destinationPath)
                    [void]$results.Add([pscustomobject][ordered]@{
                        Status       = $DistributionStatus.Distributed
                        Project      = $projectName
                        Destination  = $destinationPath
                        ChangedCount = $changedFiles.Count
                        ChangedFiles = $changedFiles.ToArray()
                        Details      = 'Template changes successfully distributed'
                    })
                }
            }
            catch {
                $errorMessage = $_.Exception.Message
                Write-Warning ("Distribution failed for {0}: {1}" -f $destinationPath, $errorMessage)
                [void]$results.Add([pscustomobject][ordered]@{
                    Status       = $DistributionStatus.CopyFailed
                    Project      = $projectName
                    Destination  = $destinationPath
                    ChangedCount = $changedFiles.Count
                    ChangedFiles = $changedFiles.ToArray()
                    Details      = "Template could not be fully distributed: $errorMessage"
                })
            }
        }

        return $results
    }
    finally {
        if (Test-Path -LiteralPath $tempRoot) {
            try {
                Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction Stop
            }
            catch {
                Write-Warning ("Could not remove temporary clone directory {0}: {1}" -f $tempRoot, $_.Exception.Message)
            }
        }
    }
}

$templateUrl = 'https://github.com/eigenverft/Eigenverft.Template.Agents.git'
$whitelist   = @( '.gitattributes', 'AGENTS.md', '.agents/**', 'AGENTS/**' )

# Projects that should receive the template overlay when they exist locally.
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
    'Eigenverft.Web.ControlPlaneMcp'
    'Eigenverft.Web.EdgeReverseProxy'
    'Eigenverft.Web.SessionBridge'
    'Eigenverft.WebLib.Infrastructure'
    'Eigenverft.Windows.ProcessIsolationRestricted'
    'Eigenverft.Windows.ProcessIsolationSandbox'
)

# Intentional exclusions are configuration and therefore appear in the report.
$explicitlyIgnoredProjects = @(
    [pscustomobject][ordered]@{
        Name   = 'Eigenverft.Template.Agents'
        Reason = 'Template source'
    }
    [pscustomobject][ordered]@{
        Name   = 'Eigenverft.Archive.All'
        Reason = 'Cold archive'
    }
    [pscustomobject][ordered]@{
        Name   = 'Eigenverft.Templates.HtmlJavascriptDemos'
        Reason = 'Independent HTML and JavaScript demo templates'
    }
    [pscustomobject][ordered]@{
        Name   = 'eigenverft'
        Reason = 'Organization profile repository'
    }
)

$destinations = @(
    $destinationNames |
        ForEach-Object { Join-Path $WorkspaceRoot $_ }
)

$distributionResults = @(
    Copy-GitTemplateSnapshot `
        -RepositoryUrl $templateUrl `
        -DestinationPaths $destinations `
        -Whitelist $whitelist
)

$report = [System.Collections.Generic.List[object]]::new()
foreach ($result in $distributionResults) {
    [void]$report.Add($result)
}

foreach ($ignoredProject in $explicitlyIgnoredProjects) {
    [void]$report.Add([pscustomobject][ordered]@{
        Status       = $DistributionStatus.ExplicitlyIgnored
        Project      = $ignoredProject.Name
        Destination  = Join-Path $WorkspaceRoot $ignoredProject.Name
        ChangedCount = 0
        ChangedFiles = @()
        Details      = $ignoredProject.Reason
    })
}

$ignoredNames = @($explicitlyIgnoredProjects | ForEach-Object { $_.Name })
$candidateDirectories = @(
    Get-ChildItem -LiteralPath $WorkspaceRoot -Directory -ErrorAction Stop |
        Where-Object {
            $_.Name -like 'Eigenverft.*' -and
            $destinationNames -notcontains $_.Name -and
            $ignoredNames -notcontains $_.Name
        } |
        Sort-Object -Property Name
)

foreach ($candidateDirectory in $candidateDirectories) {
    [void]$report.Add([pscustomobject][ordered]@{
        Status       = $DistributionStatus.Candidate
        Project      = $candidateDirectory.Name
        Destination  = $candidateDirectory.FullName
        ChangedCount = 0
        ChangedFiles = @()
        Details      = 'Local Eigenverft project has no distribution decision'
    })
}

$statusOrder = @(
    $DistributionStatus.Distributed
    $DistributionStatus.UpToDate
    $DistributionStatus.Missing
    $DistributionStatus.CopyFailed
    $DistributionStatus.Candidate
    $DistributionStatus.ExplicitlyIgnored
)

Write-Host ''
Write-Host 'Distribution report:'
foreach ($statusValue in $statusOrder) {
    $entries = @(
        $report |
            Where-Object { $_.Status -eq $statusValue } |
            Sort-Object -Property Project
    )

    foreach ($entry in $entries) {
        if ($entry.Status -eq $DistributionStatus.Distributed) {
            Write-Host ('[{0}] {1} - {2} changed file(s)' -f $entry.Status, $entry.Project, $entry.ChangedCount)
            foreach ($changedFile in @($entry.ChangedFiles)) {
                Write-Host ('  - {0}' -f $changedFile)
            }
            continue
        }

        if ($entry.Status -eq $DistributionStatus.CopyFailed -and $entry.ChangedCount -gt 0) {
            Write-Host ('[{0}] {1} - {2}; {3} file(s) changed before the failure' -f $entry.Status, $entry.Project, $entry.Details, $entry.ChangedCount)
            foreach ($changedFile in @($entry.ChangedFiles)) {
                Write-Host ('  - {0}' -f $changedFile)
            }
            continue
        }

        Write-Host ('[{0}] {1} - {2}' -f $entry.Status, $entry.Project, $entry.Details)
    }
}

Write-Host ''
Write-Host 'Distribution summary:'
foreach ($statusValue in $statusOrder) {
    $count = @($report | Where-Object { $_.Status -eq $statusValue }).Count
    Write-Host ('{0}: {1}' -f $statusValue, $count)
}
