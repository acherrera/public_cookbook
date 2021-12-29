# Docker and Docker-Compose


## Docker

```
# docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world # Test it out

# Docker without sudo
sudo groupadd docker
sudo usermod -aG docker $USER 
newgrp docker

```

## Docker-compose

Docker-compose on snap is a little outdated, this is the way to get the most recent version. Note that your docker
location may be different. Find location using `which docker-compose` and move to that location to overwrite / update
the current install


```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Docker Commands 


```
    docker ps       # All running
    docker ps -a    # All
    docker ps -a -q # All and only the hashes (used later)
```


Use these commands to start and stop contains in bulk
Basically cause use `docker ps -q` and `docker ps -a -q` to do bulk operations on either all running or all.

```
    docker stop (docker ps -a -q)   # Stop all
    docker kill (docker ps -a -q)   # Kill all (force stop)
    docker rm (docker ps -a -q)     # Remove
    docker start (docker ps -a -q)  # Start all stopped
```

## Networking

Not entirely sure how docker handles this. It creates networks and manages them, but the definitions are a little
challenging.

```
    # Show commands
    docker network

    # Remove old networks, don't ask
    docker network prune -f
```
