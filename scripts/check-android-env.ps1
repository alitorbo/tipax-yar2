$ErrorActionPreference = 'Continue'
Write-Host '=== TipaxYar Android build environment check ===' -ForegroundColor Cyan
Write-Host "OS: $([System.Environment]::OSVersion.VersionString)"
Write-Host "Architecture: $env:PROCESSOR_ARCHITECTURE"
Write-Host "JAVA_HOME: $env:JAVA_HOME"
if (Get-Command java -ErrorAction SilentlyContinue) { java -version } else { Write-Host 'JAVA/JDK: NOT FOUND' -ForegroundColor Yellow }
if (Get-Command javac -ErrorAction SilentlyContinue) { javac -version } else { Write-Host 'JDK compiler: NOT FOUND' -ForegroundColor Yellow }
Write-Host "ANDROID_HOME: $env:ANDROID_HOME"
Write-Host "ANDROID_SDK_ROOT: $env:ANDROID_SDK_ROOT"
$sdk = if ($env:ANDROID_SDK_ROOT) {$env:ANDROID_SDK_ROOT} elseif ($env:ANDROID_HOME) {$env:ANDROID_HOME} else { Join-Path $env:LOCALAPPDATA 'Android\Sdk' }
Write-Host "Candidate SDK path: $sdk"
if (Test-Path $sdk) { Get-ChildItem $sdk -Force | Select-Object Name } else { Write-Host 'Android SDK directory: NOT FOUND' -ForegroundColor Yellow }
foreach ($cmd in @('adb','gradle')) { if (Get-Command $cmd -ErrorAction SilentlyContinue) { Write-Host "$cmd found: $((Get-Command $cmd).Source)" } else { Write-Host "$cmd: not found on PATH" -ForegroundColor Yellow } }
if (Test-Path '.\gradlew.bat') { Write-Host 'Gradle Wrapper: present' } else { Write-Host 'Gradle Wrapper: not present in current directory' -ForegroundColor Yellow }
Write-Host '=== Check complete; this script does not install or change anything. ===' -ForegroundColor Cyan
