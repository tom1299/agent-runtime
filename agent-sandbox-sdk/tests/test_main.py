from agent_sandbox_sdk import greet


def test_greet() -> None:
    assert greet("uv") == "Hi, uv"


