# Influx and Grafana

Used to know how to do this but I failed to take notes, so now I get to start back from square one.

## InfluxDB

This is a time-series database. It typically runs on port 8086.

## Grafana

Tool for collecting the data. Port 3003.

## Chronograf

Tool for displaying the collected data from Grafana+InfluxDB port 3004

## Install (Docker)

Documentation for this cane be found here: https://hub.docker.com/r/philhawthorne/docker-influxdb-grafana/


Quick and dirty - be sure to replace the path volumes for the path that you actually want to use or it will fail:

```
    docker run -d \
      --name docker-influxdb-grafana \
      -p 3003:3003 \
      -p 3004:8083 \
      -p 8086:8086 \
      -v /path/for/influxdb:/var/lib/influxdb \
      -v /path/for/grafana:/var/lib/grafana \
      philhawthorne/docker-influxdb-grafana:latest
```


