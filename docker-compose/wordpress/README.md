# Wordpress on Docker-Compose

This is the yaml file for running docker-compose. 

found here: https://docs.docker.com/samples/wordpress/

Commands

```
    docker-compose up
    docker-compose down

    # Complete reset
    docker-compose down --volumes
```

## Getting this onto the machine

Use scp stupid - don't copy and paste like a chump.

```
    scp ./docker-compose.yml username@<ip_add>:/home/username/
```
