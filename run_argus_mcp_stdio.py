import os
import sys
import anyio
from mcp.server.stdio import stdio_server
from mcp.client.sse import sse_client

async def forward(read_stream, write_stream):
    async for message in read_stream:
        if isinstance(message, Exception):
            print(f"Stream error: {message}", file=sys.stderr)
            continue
        await write_stream.send(message)

async def main_async():
    # Read the token from the environment variable (provided by VSCode MCP settings)
    token = os.environ.get("ARGUS_MCP_TOKEN")
    
    if not token:
        print("Error: ARGUS_MCP_TOKEN environment variable is required.", file=sys.stderr)
        print("Please configure it in your IDE's MCP settings.", file=sys.stderr)
        sys.exit(1)
        
    # TODO: Use the production URL from the environment variable.
    url = "http://localhost:8000/mcp/sse"
    
    # Proxy the stdio streams from the IDE to the remote SSE streams
    try:
        async with stdio_server() as (stdio_read, stdio_write):
            async with sse_client(url, headers={"Authorization": f"Bearer {token}"}) as (sse_read, sse_write):
                async with anyio.create_task_group() as tg:
                    # Forward IDE -> FastAPI
                    tg.start_soon(forward, stdio_read, sse_write)
                    # Forward FastAPI -> IDE
                    tg.start_soon(forward, sse_read, stdio_write)
    except Exception as e:
        print(f"Proxy connection failed: {e}", file=sys.stderr)
        sys.exit(1)

def main():
    anyio.run(main_async)

if __name__ == "__main__":
    main()
    