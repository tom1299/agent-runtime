group "default" {
  targets = ["agent-base"]
}

group "agents" {
  targets = ["copilot-agent", "claude-agent"]
}

target "agent-base" {
  context = "."
  dockerfile = "Dockerfile.agent-base"
  tags = ["agent-base:latest"]
}

target "copilot-agent" {
  context = "."
  dockerfile = "Dockerfile.copilot"
  tags = ["copilot-agent:latest"]
}

target "claude-agent" {
  context = "."
  dockerfile = "Dockerfile.claude"
  tags = ["claude-agent:latest"]
}