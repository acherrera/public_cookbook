# Docker-Compose

Run multiple docker contains with ease!

## Installation

Docker-compose on snap is a little outdated, this is the way to get the most recent version. Note that your docker
location may be different. Find location using `which docker-compose` and move to that location to overwrite / update
the current install


```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o ./docker-compose
sudo chmod +x ./docker-compose

# Move to bin location. Snap can deal with it
sudo mv ./docker-compose /snap/bin/docker-compose

# Check version
docker-compose --version
```


## Docker-compose Commands

The docker-compose file should be stored at `./docker-compose.yml`

```
    docker-compose up                   # Start the service
    docker-compose up --force-recreate  # Start service from scratch
    docker-compose down                 # Stop the service  
    docker-compose rm                   # Remove contaienrs - will persist some data if run again.
```
