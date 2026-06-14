<#
  Install the agent-repo-card skills into a Claude Code skills directory.
    ./install.ps1          -> into .\.claude\skills (current repo)
    ./install.ps1 -User    -> into ~\.claude\skills (global)
#>
param([switch]$User)

$ErrorActionPreference = "Stop"
$src = Join-Path $PSScriptRoot "skills"

if ($User) {
  $dest = Join-Path $HOME ".claude\skills"
} else {
  $dest = Join-Path (Get-Location) ".claude\skills"
}

New-Item -ItemType Directory -Force -Path $dest | Out-Null

Get-ChildItem -Path $src -Directory | ForEach-Object {
  $target = Join-Path $dest $_.Name
  if (Test-Path $target) { Remove-Item -Recurse -Force $target }
  Copy-Item -Recurse -Path $_.FullName -Destination $target
  Write-Host "installed: $($_.Name) -> $target"
}

Write-Host "Done. Open Claude Code here and try: /ux-audit"
