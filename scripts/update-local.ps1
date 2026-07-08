<#
.SYNOPSIS
    Riallinea il marketplace enricopezzini in locale.

.DESCRIPTION
    1. Fa `git pull` nel repo del marketplace (per prendere le skill nuove/aggiornate).
    2. Riallinea il manifest del marketplace nel plugin manager di Claude.
    3. Reinstalla il plugin `core` all'ultima versione (versioning via SHA git).

    Eseguibile da qualsiasi account: usa il path del repo dove si trova lo script,
    non un path hard-coded.

.EXAMPLE
    pwsh ./scripts/update-local.ps1
#>
[CmdletBinding()]
param(
    [string]$Marketplace = "enricopezzini",
    [string]$Plugin      = "core"
)

$ErrorActionPreference = "Stop"

# Root del repo = cartella padre di /scripts
$RepoRoot = Split-Path -Parent $PSScriptRoot
Write-Host "==> Repo marketplace: $RepoRoot" -ForegroundColor Cyan

Push-Location $RepoRoot
try {
    Write-Host "==> git pull..." -ForegroundColor Cyan
    git pull --ff-only
    if ($LASTEXITCODE -ne 0) { throw "git pull fallito (exit $LASTEXITCODE)" }

    Write-Host "==> claude plugin marketplace update $Marketplace..." -ForegroundColor Cyan
    claude plugin marketplace update $Marketplace
    if ($LASTEXITCODE -ne 0) { throw "marketplace update fallito (exit $LASTEXITCODE)" }

    Write-Host "==> claude plugin install $Plugin@$Marketplace..." -ForegroundColor Cyan
    claude plugin install "$Plugin@$Marketplace"
    if ($LASTEXITCODE -ne 0) { throw "plugin install fallito (exit $LASTEXITCODE)" }

    Write-Host "==> Fatto. Skill riallineate all'ultima versione." -ForegroundColor Green
}
finally {
    Pop-Location
}
