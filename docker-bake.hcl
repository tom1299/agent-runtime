group "default" {
  targets = ["agent-base"]
}

group "agents" {
  targets = ["copilot-agent", "claude-agent"]
}

target "agent-base" {
  context = "."
  dockerfile = "Dockerfile.agent-base"
  tags = [
      "ghcr.io/tom1299/agent-runtime/agent-base:latest"
  ]
}

target "copilot-agent" {
  context = "."
  dockerfile = "Dockerfile.copilot"
  tags = [
      "ghcr.io/tom1299/agent-runtime/copilot-agent:latest"
  ]
}

target "claude-agent" {
  context = "."
  dockerfile = "Dockerfile.claude"
  tags = [
      "ghcr.io/tom1299/agent-runtime/claude-agent:latest"
  ]
}