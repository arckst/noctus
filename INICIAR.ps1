$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$runtime = (Get-Command node -ErrorAction SilentlyContinue).Source
if (-not $runtime) {
  $bundled = Join-Path $env:USERPROFILE '.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node.exe'
  if (Test-Path -LiteralPath $bundled) { $runtime = $bundled } else { throw 'Instale Node.js 22.13 ou superior e execute novamente.' }
}
Write-Host 'Iniciando Noctus Pixel. Mantenha esta janela aberta.'
Write-Host 'Abra o endereço Local exibido abaixo no navegador.'
& $runtime scripts/run-framework.mjs dev
