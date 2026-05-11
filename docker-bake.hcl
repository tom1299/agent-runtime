group "agents" {
  targets = ["copilot-agent"]
}

target "agent-base" {
  context = "."
  dockerfile = "Dockerfile.agent-base"
  tags = ["agent-base:latest"]
  no-cache = true
}

target "copilot-agent" {
  context = "."
  dockerfile = "Dockerfile.copilot"
  tags = ["agent-base:latest"]
}