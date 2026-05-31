def test_connection_to_cluster(cluster_client) -> None:
    sandbox = cluster_client.create_sandbox(
        template="simple-sandbox-template", namespace="default"
    )
    try:
        result = sandbox.commands.run("echo 'Hello from Local!'")
        assert "Hello from Local!" in result.stdout
    finally:
        sandbox.terminate()

