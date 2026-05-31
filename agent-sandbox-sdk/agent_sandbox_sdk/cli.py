from k8s_agent_sandbox import SandboxClient
from k8s_agent_sandbox.models import SandboxLocalTunnelConnectionConfig

def main() -> None:

    client = SandboxClient(
        connection_config=SandboxLocalTunnelConnectionConfig()
    )

    sandbox = client.create_sandbox(template="simple-sandbox-template", namespace="default")
    try:
        print(sandbox.commands.run("echo 'Hello from Local!'").stdout)
    finally:
        sandbox.terminate()

if __name__ == "__main__":
    main()
