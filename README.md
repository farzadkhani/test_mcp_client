# Argus MCP Client

A bridge client that connects local IDEs using the `stdio` Model Context Protocol (MCP) to a remote MCP server running over Server-Sent Events (SSE).

This allows your local IDE to seamlessly communicate with remote MCP tools securely and efficiently.

## Using with VS Code

VS Code supports MCP via workspace or user `mcp.json` (see [MCP in VS Code](https://code.visualstudio.com/docs/copilot/customization/mcp)). Create `.vscode/mcp.json` in your project (or configure user-level MCP settings).

### macOS / Linux (global install)

```json
{
  "servers": {
    "argus-mcp": {
      "command": "/Users/YOUR_USERNAME/.argus-mcp/.venv/bin/python",
      "args": [
        "/Users/YOUR_USERNAME/.argus-mcp/run_argus_mcp_stdio.py"
      ],
      "env": {
        "ARGUS_MCP_TOKEN": "YOUR-ARGUS-TOKEN-HERE",
        "ARGUS_MCP_URL": "http://localhost:11503/mcp/sse"
      }
    }
  }
}
```

### Windows (global install)

Replace `YOUR_USERNAME` with your Windows profile folder name (the installer prints the full paths when it finishes):

```json
{
  "servers": {
    "argus-mcp": {
      "command": "C:\\Users\\YOUR_USERNAME\\.argus-mcp\\.venv\\Scripts\\python.exe",
      "args": [
        "C:\\Users\\YOUR_USERNAME\\.argus-mcp\\run_argus_mcp_stdio.py"
      ],
      "env": {
        "ARGUS_MCP_TOKEN": "YOUR-ARGUS-TOKEN-HERE",
        "ARGUS_MCP_URL": "http://localhost:11503/mcp/sse"
      }
    }
  }
}
```

## Environment Variables

Regardless of the IDE or extension you use, the proxy client requires two environment variables to establish the connection to the remote SSE server:

- `ARGUS_MCP_TOKEN`: Your authorization token. This is sent as a `Bearer` token in the `Authorization` header.
- `ARGUS_MCP_URL`: The URL of your remote SSE server endpoint (e.g., `https://api.yourdomain.com/mcp/sse` or `http://localhost:11503/mcp/sse`).
- *replace `*/Users/YOUR_USERNAME/`* with return of bash command*

## Installation

### macOS / Linux

Install globally to `~/.argus-mcp`:

```bash
curl -sSL https://raw.githubusercontent.com/farzadkhani/test_mcp_client/refs/heads/main/install_argus_mcp_stdio.sh | bash
```

### Windows (PowerShell)

Install globally to `%USERPROFILE%\.argus-mcp` (requires [Python 3](https://www.python.org/downloads/) on PATH):

```powershell
irm https://raw.githubusercontent.com/farzadkhani/test_mcp_client/refs/heads/main/install_argus_mcp_stdio.ps1 | iex
```

