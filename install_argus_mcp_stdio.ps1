#Requires -Version 5.1
$ErrorActionPreference = "Stop"

$InstallDir = Join-Path $env:USERPROFILE ".argus-mcp"
$ScriptPath = Join-Path $InstallDir "run_argus_mcp_stdio.py"
$VenvDir = Join-Path $InstallDir ".venv"
$PythonBin = Join-Path $VenvDir "Scripts\python.exe"
$ScriptUrl = "https://raw.githubusercontent.com/farzadkhani/test_mcp_client/refs/heads/main/run_argus_mcp_stdio.py"

function Get-PythonLauncher {
    if (Get-Command python -ErrorAction SilentlyContinue) {
        return @{ Exe = "python"; Args = @() }
    }
    if (Get-Command py -ErrorAction SilentlyContinue) {
        return @{ Exe = "py"; Args = @("-3") }
    }
    throw @"
Python 3 was not found on PATH.
Install Python from https://www.python.org/downloads/ and enable 'Add python.exe to PATH'.
"@
}

Write-Host "Installing Argus MCP Client..."

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null

Write-Host "Downloading run_argus_mcp_stdio.py..."
Invoke-WebRequest -Uri $ScriptUrl -OutFile $ScriptPath -UseBasicParsing

Write-Host "Setting up Python environment..."
$launcher = Get-PythonLauncher
$venvArgs = $launcher.Args + @("-m", "venv", $VenvDir)
& $launcher.Exe @venvArgs

if (-not (Test-Path $PythonBin)) {
    throw "Virtual environment was not created at: $PythonBin"
}

& $PythonBin -m pip install -q mcp anyio httpx

Write-Host ""
Write-Host "Installation complete."
Write-Host "Install directory: $InstallDir"
Write-Host ""
$JsonPython = $PythonBin -replace '\\', '\\\\'
$JsonScript = $ScriptPath -replace '\\', '\\\\'

Write-Host "VS Code MCP configuration (.vscode/mcp.json in your workspace):"
Write-Host @"
{
  "servers": {
    "argus-mcp": {
      "command": "$JsonPython",
      "args": [
        "$JsonScript"
      ],
      "env": {
        "ARGUS_MCP_TOKEN": "YOUR-ARGUS-TOKEN-HERE",
        "ARGUS_MCP_URL": "http://localhost:8000/mcp/sse"
      }
    }
  }
}
"@
