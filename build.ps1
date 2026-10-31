# Windows build: assemble with tools\bin\asar.exe (or asar on PATH) and verify sha1 against lst\nhl95snes.sfc.
python tools/prebuild.py; if ($LASTEXITCODE -ne 0) { exit 1 }
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$asar = Join-Path $PSScriptRoot 'tools\bin\asar.exe'; if (-not (Test-Path $asar)) { $asar = 'asar' }
New-Item -ItemType Directory -Force -Path output | Out-Null
Remove-Item -ErrorAction SilentlyContinue output\nhl95snes.sfc
& $asar --fix-checksum=off --symbols=wla --symbols-path=output/nhl95snes.sym src/nhl95snes.asm output/nhl95snes.sfc
if ($LASTEXITCODE -ne 0 -or -not (Test-Path output\nhl95snes.sfc)) { Write-Host 'MISMATCH (assembly failed)'; exit 1 }
$ref = (Get-FileHash -Algorithm SHA1 lst\nhl95snes.sfc).Hash.ToLower()
$out = (Get-FileHash -Algorithm SHA1 output\nhl95snes.sfc).Hash.ToLower()
Write-Host "ref $ref"; Write-Host "out $out"
if ($ref -eq $out) { Write-Host 'MATCH' } else {
  Write-Host 'MISMATCH'
  $a = [IO.File]::ReadAllBytes('lst\nhl95snes.sfc'); $b = [IO.File]::ReadAllBytes('output\nhl95snes.sfc')
  $n = 0; for ($i = 0; $i -lt [Math]::Min($a.Length, $b.Length) -and $n -lt 20; $i++) { if ($a[$i] -ne $b[$i]) { '{0:X5} retail {1:X2} built {2:X2}' -f $i, $a[$i], $b[$i]; $n++ } }
  exit 1 }
