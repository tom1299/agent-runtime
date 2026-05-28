from k8s_agent_sandbox import SandboxClient

validation_message = "volume validation"

client = SandboxClient()

sandbox1 = client.create_sandbox("simple-sandbox-template")
response1 = sandbox1.commands.run(f"sh -c \"echo '{validation_message}' > /data/volume_validation.txt\"")
print(f"Claim Name: {sandbox1.claim_name}")

client2 = SandboxClient()
sandbox2 = client2.get_sandbox(sandbox1.claim_name)
response2 = sandbox2.commands.run(f"sh -c \"cat /data/volume_validation.txt\"")

assert response2.stdout.strip() == validation_message, f"\"{response2.stdout.strip()}\" != \"{validation_message}\"."
print(f"response2.stdout.strip(): {response2.stdout.strip()}")
sandbox2.terminate()

