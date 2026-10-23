# Local packaging only. Does not deploy or access sibling directories.
$ErrorActionPreference = 'Stop'
$sourceRoot = $PSScriptRoot
$outputRoot = Join-Path $sourceRoot 'publish'
if (Test-Path -LiteralPath $outputRoot) { throw 'publish already exists. Review/remove that generated directory before preparing a fresh copy; this script never merges stale files.' }
$files = @('index.html', 'styles.css', '404.html', '_headers', 'assets/apex-logo.webp', 'assets/IMG_7440-800.webp', 'assets/IMG_7617-1600.webp', 'assets/IMG_7617-800.webp', 'assets/IMG_7759-800.webp', 'assets/IMG_7765-1600.webp', 'assets/IMG_7765-800.webp', 'assets/IMG_8246-800.webp')
foreach ($file in $files) { if (-not (Test-Path -LiteralPath (Join-Path $sourceRoot $file) -PathType Leaf)) { throw "Missing required file: $file" } }
New-Item -ItemType Directory -Path (Join-Path $outputRoot 'assets') | Out-Null
foreach ($file in $files) { Copy-Item -LiteralPath (Join-Path $sourceRoot $file) -Destination (Join-Path $outputRoot $file) }
Write-Output 'Prepared publish/. Upload only its contents to Cloudflare Pages. No deployment performed.'
