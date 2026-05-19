# Argus MCP Client

A bridge client that connects local IDEs using the `stdio` Model Context Protocol (MCP) to a remote MCP server running over Server-Sent Events (SSE).

This allows your local IDE to seamlessly communicate with remote MCP tools securely and efficiently.

## Using with Cursor

Cursor has built-in native support for the Model Context Protocol.

1. Open **Cursor Settings**
2. Navigate to **Features** -> **MCP**
3. Click on **+ Add New MCP Server**
4. Configure the server with the settings below based on how you installed it.

**For Global Installation (using the install script):**

- **Type:** `command`
- **Name:** `argus-mcp`
- **Command:** `/Users/YOUR_USERNAME/.argus-mcp/.venv/bin/python`
- **Args:** `/Users/YOUR_USERNAME/.argus-mcp/run_argus_mcp_stdio.py`
*(Make sure to replace `/Users/YOUR_USERNAME` with your actual home directory).*

Under the **Environment Variables** section, add:

- `ARGUS_MCP_TOKEN`: `YOUR-ARGUS-TOKEN-HERE`
- `ARGUS_MCP_URL`: `http://localhost:8000/mcp/sse`

**For Local Development (cloned repository):**

- **Type:** `command`
- **Name:** `argus-mcp`
- **Command:** `${workspaceFolder}/.venv/bin/python`
- **Args:** `${workspaceFolder}/run_argus_mcp_stdio.py`

Under the **Environment Variables** section, add:

- `PYTHONPATH`: `${workspaceFolder}`
- `ARGUS_MCP_TOKEN`: `YOUR-ARGUS-TOKEN-HERE`
- `ARGUS_MCP_URL`: `http://localhost:8000/mcp/sse`

## Using with VS Code

Visual Studio Code does not natively support MCP servers out of the box, but you can use it with AI assistant extensions like **Cline**, **GitHub Copilot** (via MCP integrations), or **Roo Code** (formerly Roo Cline).

### Configuring for Cline / Roo Code

create .vscode/mcp.json

```json
{
  "mcpServers": {
    "argus-mcp": {
      "command": "/Users/YOUR_USERNAME/.argus-mcp/.venv/bin/python",
      "args": [
        "/Users/YOUR_USERNAME/.argus-mcp/run_argus_mcp_stdio.py"
      ],
      "env": {
        "ARGUS_MCP_TOKEN": "YOUR-ARGUS-TOKEN-HERE",
        "ARGUS_MCP_URL": "http://localhost:8000/mcp/sse"
      }
    }
  }
}
```

## Environment Variables

Regardless of the IDE or extension you use, the proxy client requires two environment variables to establish the connection to the remote SSE server:

- `ARGUS_MCP_TOKEN`: Your authorization token. This is sent as a `Bearer` token in the `Authorization` header.
- `ARGUS_MCP_URL`: The URL of your remote SSE server endpoint (e.g., `https://api.yourdomain.com/mcp/sse` or `http://localhost:8000/mcp/sse`).
- *replace `*/Users/YOUR_USERNAME/`* with return of bash command*

## Installation

You can quickly install the Argus MCP client globally to your home directory (`~/.argus-mcp`) by running the following command in your terminal:

```bash
curl -sSL https://raw.githubusercontent.com/farzadkhani/test_mcp_client/refs/heads/main/install_argus_mcp_stdio.sh | bash
```

*(This will set up a dedicated Python virtual environment and install the required dependencies like `mcp`, `anyio`, and `httpx`.)*