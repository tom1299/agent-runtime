import os

import pytest
from k8s_agent_sandbox import SandboxClient
from k8s_agent_sandbox.models import SandboxLocalTunnelConnectionConfig


def __create_client() -> SandboxClient:
    return SandboxClient(connection_config=SandboxLocalTunnelConnectionConfig())

@pytest.fixture(scope="session")
def cluster_client():
    if os.getenv("RUN_CLUSTER_TESTS") != "1":
        pytest.skip("Set RUN_CLUSTER_TESTS=1 to run cluster integration tests.")
    return __create_client()

