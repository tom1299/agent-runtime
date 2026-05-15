# Container Setup

## Usage

Start all services:

```bash
DNS_SERVER=10.33.255.21 WORKSPACE_DIR=~/git/github/agent-runtime docker-compose up
```

Rebuild the copilot image without cache:

```bash
DNS_SERVER=10.33.255.21 docker-compose build --no-cache copilot
```

Attach to the copilot container:

```bash
docker exec -it copilot bash
```

## Copilot authentication
Run
```
gh auth token
```
on host. Put token in `.env` or export as env var `GITHUB_TOKEN=gho....`

## DNS Configuration

DNS is configured in two places:

- **DinD**: Set the `DNS_SERVER` environment variable when running `docker-compose up` (see above). It is passed to the `dind` service via `dind-entrypoint.sh`.
- **BuildKit**: Edit `buildkitd.toml` to change the nameservers used during builds:

  ```toml
  [dns]
    nameservers = ["10.33.255.21"]
  ```

  This file is mounted into the `buildkitd` container at `/etc/buildkit/buildkitd.toml`.

## Test
Run the test script to verify that all services start correctly and that BuildKit can resolve DNS:

```bash
DNS_SERVER=10.33.255.21 ./test.sh
```

## TODO
* Create bake file for k8s-kind gvisor node image (push to gh registry)
* Create test for gvsior Pod:
  ```
  kubectl apply -f - <<'EOF'                                                       
  apiVersion: v1                                                                                                                 │[   1.477590] Conjuring /dev/null black hole...
  kind: Pod                                                                                                                      │[   1.531258] Verifying that no non-zero bytes made their way into /dev/zero...
  metadata:                                                                                                                      │[   1.623763] Politicking the oom killer...
    name: gvisor-demo                                                                                                            │[   1.813298] Reticulating splines...
  spec:                                                                                                                          │[   2.091817] Checking naughty and nice process list...
    runtimeClassName: gvisor                                                                                                     │[   2.106557] Synthesizing system calls...
    containers:                                                                                                                  │[   2.512954] Ready!
      - name: app                                                                                                                │root@agent-runtime-control-plane:/# uname -m
        image: nginx:stable                                                                                                      │x86_64
        command: ["sh", "-c", "sleep 3600"]                                                                                      │root@agent-runtime-control-plane:/# exit
  EOF
  
  k exec -ti gvisor-demo -- dmesg
  ```
* Finish bake file for agents
* Make DNS configuration simpler
* Remove no sandbox option from BuildKit
* BuildKit: seccomp unconfined for privileged ? Which is better
