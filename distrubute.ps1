function Copy-GitTemplateSnapshot {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidatePattern('^https://')]
        [string]$RepositoryUrl,

        [Parameter(Mandatory)]
        [string]$DestinationPath,

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

    if (-not [System.IO.Path]::IsPathRooted($DestinationPath)) {
        throw "DestinationPath must be an absolute path."
    }

    $tempRoot  = Join-Path ([System.IO.Path]::GetTempPath()) ("git-template-" + [guid]::NewGuid().ToString("N"))
    $clonePath = Join-Path $tempRoot "repo"
    $copied    = [System.Collections.Generic.List[string]]::new()

    try {
        New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null

        git clone --depth 1 $RepositoryUrl $clonePath
        if ($LASTEXITCODE -ne 0) {
            throw "git clone failed."
        }

        New-Item -ItemType Directory -Path $DestinationPath -Force | Out-Null

        $cloneRootPrefix = $clonePath.TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar

        Get-ChildItem -LiteralPath $clonePath -Recurse -File -Force |
            Where-Object { $_.FullName -notlike (Join-Path $clonePath '.git*') } |
            ForEach-Object {
                $relativePath = $_.FullName.Substring($cloneRootPrefix.Length).Replace('\', '/')

                if (-not (Test-WhitelistMatch -RelativePath $relativePath -Patterns $Whitelist)) {
                    return
                }

                $destinationFile = Join-Path $DestinationPath $relativePath
                $destinationDir  = Split-Path -Path $destinationFile -Parent

                if (-not (Test-Path -LiteralPath $destinationDir)) {
                    New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
                }

                Copy-Item -LiteralPath $_.FullName -Destination $destinationFile -Force
                [void]$copied.Add($relativePath)
            }

        return $copied
    }
    finally {
        if (Test-Path -LiteralPath $tempRoot) {
            Remove-Item -LiteralPath $tempRoot -Recurse -Force
        }
    }
}

$whitelist = @( 'AGENTS.md', '.agents/**')

Copy-GitTemplateSnapshot -RepositoryUrl "https://github.com/eigenverft/Eigenverft.Template.Agents.git" -DestinationPath "C:\dev\github.com\eigenverft\Eigenverft.Template.Agents" -Whitelist $whitelist
Copy-GitTemplateSnapshot -RepositoryUrl "https://github.com/eigenverft/Eigenverft.Template.Agents.git" -DestinationPath "C:\dev\github.com\eigenverft\Eigenverft.Manifested.Sandbox" -Whitelist $whitelist
Copy-GitTemplateSnapshot -RepositoryUrl "https://github.com/eigenverft/Eigenverft.Template.Agents.git" -DestinationPath "C:\dev\github.com\eigenverft\Eigenverft.Manifested.Agent" -Whitelist $whitelist
Copy-GitTemplateSnapshot -RepositoryUrl "https://github.com/eigenverft/Eigenverft.Template.Agents.git" -DestinationPath "C:\dev\github.com\eigenverft\Eigenverft.Manifested.Drydock" -Whitelist $whitelist
Copy-GitTemplateSnapshot -RepositoryUrl "https://github.com/eigenverft/Eigenverft.Template.Agents.git" -DestinationPath "C:\dev\github.com\eigenverft\Eigenverft.Routed.RequestFilters" -Whitelist $whitelist
