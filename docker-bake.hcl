group "default" {
  targets = ["agent-base"]
}

group "agents" {
  targets = ["copilot-agent", "claude-agent", "opencode-agent"]
}

target "agent-base" {
  context = "."
  dockerfile = "Dockerfile.agent-base"
  tags = [
      "ghcr.io/tom1299/agent-runtime/agent-base:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/tom1299/agent-runtime"
  }
}

target "copilot-agent" {
  context = "."
  dockerfile = "Dockerfile.copilot"
  tags = [
      "ghcr.io/tom1299/agent-runtime/copilot-agent:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/tom1299/agent-runtime"
  }
}

target "claude-agent" {
  context = "."
  dockerfile = "Dockerfile.claude"
  tags = [
      "ghcr.io/tom1299/agent-runtime/claude-agent:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/tom1299/agent-runtime"
  }
}

target "opencode-agent" {
  context = "."
  dockerfile = "Dockerfile.opencode"
  tags = [
      "ghcr.io/tom1299/agent-runtime/opencode-agent:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/tom1299/agent-runtime"
  }
}