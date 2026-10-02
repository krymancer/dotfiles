# Point Docker tooling (docker-compose, Testcontainers, devcontainers) at rootless podman
if set -q XDG_RUNTIME_DIR; and test -S $XDG_RUNTIME_DIR/podman/podman.sock
    set --export DOCKER_HOST unix://$XDG_RUNTIME_DIR/podman/podman.sock
end
