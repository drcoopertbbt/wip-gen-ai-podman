

## Flowise Steps

- a1

```
ssh student@sheldon.planolab.io
```

- a

```
sudo dnf install podman
podman pull docker.io/flowiseai/flowise:latest

```

- 1

```
systemctl stop firewalld
systemctl disable firewalld
```
- 2

```
podman volume create flowise-volume-sheldon
```

- 2

```
podman run -d \
--rm --name flowise \
-p 3000:3000 \
--volume flowise-volume-sheldon:/data \
-e DATABASE_PATH=/data/.flowise \
docker.io/flowiseai/flowise:latest \
flowise start
```

- 3

```
podman ps
```

- 3b

```
sudo dnf install dnf-plugin-system-upgrade
sudo dnf config-manager --set-enabled fedora
sudo dnf install fedora-repos-rawhide
sudo dnf config-manager --set-disabled '*'
sudo dnf config-manager --set-enabled rawhide
sudo dnf system-upgrade download --releasever=rawhide --allowerasing --best
sudo dnf system-upgrade reboot
sudo dnf update

```

- 4 "Couldn't Get this running"

Create Quadlet file:

```
sudo vim /etc/containers/systemd/flowise.container
```

Quadlet formatted Systemd file

```
[Unit]
Description=The Flowise container
After=local-fs.target network.target

[Container]
Image=docker.io/flowiseai/flowise:latest
ExecStartPre=-/usr/bin/podman rm -f flowise
ExecStart=/usr/bin/podman run -d --name flowise -p 3000:3000 --volume flowise-volume-sheldon:/data -e DATABASE_PATH=/data/.flowise docker.io/flowiseai/flowise:latest flowise start
ExecStop=/usr/bin/podman stop flowise
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target default.target
```

Reload Service Daemon

```
systemctl daemon-reload
```

Start and Persist Reboots with custom Podman container via Quadlet

```
systemctl start flowise.service

```