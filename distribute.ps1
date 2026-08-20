# Overlays agent instruction files from Eigenverft.Template.Agents into sibling repos.
# Copy-only by default: paths removed or renamed in the template intentionally remain in
# target repositories, so local additional, project-specific, or older skills can coexist.
# -ForceSkillReplacement removes each available target's complete .agents tree before the
# overlay, producing a strict rollout without retaining local or obsolete .agents content.
# Distribution creates or updates paths present in the current template; matching relative
# paths are overwritten only when their content differs.
# You run this script; it does not commit.

# SupportsShouldProcess is justified because strict rollouts recursively replace target .agents trees.
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$WorkspaceRoot,

    [switch]$ForceSkillReplacement
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
    NotApplied        = 'NotApplied'
    Candidate         = 'Candidate'
    ExplicitlyIgnored = 'ExplicitlyIgnored'
}

function Test-FileContentEqual {
    <#
    .SYNOPSIS
    Determines whether two files currently have identical content.

    .DESCRIPTION
    Compares the current length and SHA-256 hash of a source file and destination file.
    Returns false when the destination file does not exist. This stateful filesystem helper
    is intentionally defined at script scope rather than as a deterministic inline helper.

    .PARAMETER SourcePath
    Path to the source file whose current content is the reference.

    .PARAMETER DestinationPath
    Path to the destination file to compare with the source file.

    .EXAMPLE
    Test-FileContentEqual -SourcePath $source -DestinationPath $destination

    Returns true when both files currently have the same length and SHA-256 hash.

    .NOTES
    File content is read from the filesystem each time the function is called.
    #>
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

# SupportsShouldProcess is justified because this function can recursively replace target .agents trees.
function Copy-GitTemplateSnapshot {
    <#
    .SYNOPSIS
    Distributes a filtered Git template snapshot to local destination directories.

    .DESCRIPTION
    Creates a shallow temporary clone of an HTTPS Git repository, selects files through a
    whitelist, and overlays changed files onto each available destination. An optional strict
    rollout removes and recreates each destination's complete .agents tree before copying.
    ShouldProcess protects all destination mutations while still allowing WhatIf to inspect
    the remote snapshot and report the planned operation.

    .PARAMETER RepositoryUrl
    HTTPS URL of the Git repository used as the template source.

    .PARAMETER DestinationPaths
    Absolute local directory paths that may receive the template snapshot.

    .PARAMETER Whitelist
    Glob patterns selecting repository-relative files from the cloned template.

    .PARAMETER ForceSkillReplacement
    Removes and recreates the complete .agents tree in each available destination before the
    current template snapshot is distributed.

    .EXAMPLE
    Copy-GitTemplateSnapshot -RepositoryUrl $templateUrl -DestinationPaths $destinations

    Overlays all files selected by the default whitelist onto the available destinations.

    .EXAMPLE
    $parameters = @{
        RepositoryUrl        = $templateUrl
        DestinationPaths     = $destinations
        Whitelist            = $whitelist
        ForceSkillReplacement = $true
        WhatIf               = $true
    }
    Copy-GitTemplateSnapshot @parameters

    Reads the remote snapshot and previews strict .agents replacement without changing a
    destination.

    .NOTES
    The temporary clone is created and removed even during WhatIf because it is required for
    read-only source discovery. The function does not commit or push destination changes.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidatePattern('^https://')]
        [string]$RepositoryUrl,

        [Parameter(Mandatory)]
        [string[]]$DestinationPaths,

        [string[]]$Whitelist = @('*'),

        [switch]$ForceSkillReplacement
    )

    # Converts one whitelist glob into an anchored regular expression.
    function local:_Convert-GlobToRegex {
        [Diagnostics.CodeAnalysis.SuppressMessage("PSUseApprovedVerbs","")]
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

    # Tests whether one repository-relative path matches any whitelist pattern.
    function local:_Test-WhitelistMatch {
        [Diagnostics.CodeAnalysis.SuppressMessage("PSUseApprovedVerbs","")]
        param(
            [Parameter(Mandatory)]
            [string]$RelativePath,

            [Parameter(Mandatory)]
            [string[]]$Patterns
        )

        $normalizedPath = $RelativePath.Replace('\', '/')

        foreach ($pattern in $Patterns) {
            $rx = _Convert-GlobToRegex -Pattern $pattern
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
        # The temporary snapshot is required for both real runs and WhatIf previews.
        New-Item -ItemType Directory -Path $tempRoot -Force -ErrorAction Stop -WhatIf:$false | Out-Null

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
                Where-Object { _Test-WhitelistMatch -RelativePath $_.RelativePath -Patterns $Whitelist }
        )

        Write-Host ("Whitelisted files: {0}" -f $sourceFiles.Count)

        $sourceAgentsFiles = @(
            $sourceFiles |
                Where-Object { $_.RelativePath -ilike '.agents/*' }
        )

        if ($ForceSkillReplacement -and $sourceAgentsFiles.Count -eq 0) {
            throw 'Strict skill rollout requires at least one whitelisted .agents file in the template.'
        }

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
            $removedAgentsFileCount = 0

            try {
                $action = if ($ForceSkillReplacement) {
                    'Remove the complete .agents tree and distribute the current template snapshot'
                }
                else {
                    'Overlay the current template snapshot'
                }

                if (-not $PSCmdlet.ShouldProcess($destinationPath, $action)) {
                    [void]$results.Add([pscustomobject][ordered]@{
                        Status       = $DistributionStatus.NotApplied
                        Project      = $projectName
                        Destination  = $destinationPath
                        ChangedCount = 0
                        ChangedFiles = @()
                        Details      = if ($WhatIfPreference) {
                            'WhatIf preview only; no files changed'
                        }
                        else {
                            'Distribution was not approved'
                        }
                    })
                    continue
                }

                if ($ForceSkillReplacement) {
                    $resolvedDestinationPath = (Resolve-Path -LiteralPath $destinationPath -ErrorAction Stop).Path
                    $destinationPrefix = $resolvedDestinationPath.TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar
                    $targetAgentsPath = [System.IO.Path]::GetFullPath(
                        (Join-Path $resolvedDestinationPath '.agents')
                    )

                    if (-not $targetAgentsPath.StartsWith(
                        $destinationPrefix,
                        [System.StringComparison]::OrdinalIgnoreCase
                    )) {
                        throw "Resolved .agents replacement path escaped its destination: $targetAgentsPath"
                    }

                    if (Test-Path -LiteralPath $targetAgentsPath) {
                        $removedAgentsFileCount = @(
                            Get-ChildItem -LiteralPath $targetAgentsPath -Recurse -File -Force -ErrorAction Stop
                        ).Count

                        Write-Host ("Removing existing .agents tree -> {0}" -f $targetAgentsPath)
                        Remove-Item -LiteralPath $targetAgentsPath -Recurse -Force -ErrorAction Stop
                    }

                    New-Item -ItemType Directory -Path $targetAgentsPath -ErrorAction Stop | Out-Null
                }

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
                    $details = 'Template changes successfully distributed'
                    if ($ForceSkillReplacement) {
                        $details = 'Strict skill replacement completed; .agents was recreated from the current template'
                    }

                    [void]$results.Add([pscustomobject][ordered]@{
                        Status       = $DistributionStatus.Distributed
                        Project      = $projectName
                        Destination  = $destinationPath
                        ChangedCount = $changedFiles.Count
                        ChangedFiles = $changedFiles.ToArray()
                        Details      = $details
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
                    Details      = if ($ForceSkillReplacement) {
                        "Strict skill replacement could not be completed after removing $removedAgentsFileCount existing .agents file(s): $errorMessage"
                    }
                    else {
                        "Template could not be fully distributed: $errorMessage"
                    }
                })
            }
        }

        return $results
    }
    finally {
        if (Test-Path -LiteralPath $tempRoot) {
            try {
                Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction Stop -WhatIf:$false
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
    'Eigenverft.NetLib.Infrastructure'
    'Eigenverft.NetLib.SerilogCentralLoggingSink'
    'Eigenverft.NetLib.SerilogThemes'
    'Eigenverft.NetLib.SqliteHotBackup'
    'Eigenverft.Routed.RequestFilters'
    'Eigenverft.Service.CentralLogging'
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
        Name   = 'Eigenverft.Meta.Foundation'
        Reason = 'Meta repository'
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

$copyTemplateParameters = @{
    RepositoryUrl         = $templateUrl
    DestinationPaths      = $destinations
    Whitelist             = $whitelist
    ForceSkillReplacement = $ForceSkillReplacement
    WhatIf                = $WhatIfPreference
}

$distributionResults = @(Copy-GitTemplateSnapshot @copyTemplateParameters)

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
    $DistributionStatus.NotApplied
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
