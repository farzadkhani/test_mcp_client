#!/bin/bash
set -e

INSTALL_DIR="$HOME/.argus-mcp"
PYTHON_BIN="$INSTALL_DIR/.venv/bin/python"
SCRIPT_PATH="$INSTALL_DIR/run_mcp_stdio.py"

echo "🚀 Installing Argus MCP Client..."

mkdir -p "$INSTALL_DIR"

# TODO: Replace with your actual raw URL
curl -sSL https://raw.githubusercontent.com/your-org/project-argus/main/back/run_argus_mcp_stdio.py -o "$SCRIPT_PATH"
echo "📦 Setting up Python environment..."

python3 -m venv "$INSTALL_DIR/.venv"
"$PYTHON_BIN" -m pip install -q mcp anyio httpx

echo "✅ Installation Complete!"
echo "The Argus MCP client has been installed to: $INSTALL_DIR"