# InfluxDB

This is a time-series database. It typically runs on port 8086.

Tutorial on using influxdb: https://jensd.be/1249/linux/get-started-with-influxdb-and-python-on-linux

## Install (Docker)

Documentation for this cane be found here: https://hub.docker.com/r/philhawthorne/docker-influxdb-grafana/


Quick and dirty - be sure to replace the path volumes for the path that you actually want to use or it will fail:

```
    docker run -d \
      --name docker-influxdb-grafana \
      --restart always \
      -p 3003:3003 \
      -p 3004:8083 \
      -p 8086:8086 \
      -v /path/for/influxdb:/var/lib/influxdb \
      -v /path/for/grafana:/var/lib/grafana \
      philhawthorne/docker-influxdb-grafana:latest
```

## Install (Direct)

The above will start a few extra services to view the data as well. If you only want influxdb you can run the follow to
install and run the database as a service.

```
sudo apt-get install influxdb
sudo systemctl start influxdb
sudo systemctl enable influxdb
```

The database will connect without any authentication which is a big issue. To fix this will need to create a user in the
database with a password and we might as well give that use all priviledges.

```
influx
> CREATE USER admin WITH PASSWORD 'secretpassword' WITH ALL PRIVILEGES;
> SHOW USERS;
> EXIT
```

After that, time to enable authentication. This is done by editing the config file and setting `auth_enabled` to true.
`sudo vi /etc/influxdb/influxdb.conf`

Now restart the service: `sudo systemctl restart influxdb`. You can connect to it as before, except if you try and do
anything it will return an error. Need to add the `--username` and the `--password` flag to the influx command.

## Basics

### Connecting to the database

Will need influxdb to connect to the database:

```
sudo apt install influxdb-client python3-influxdb
```

**NOTE**: Can add `influx` to the above if you want to run an influx database locally. Since we are connecting to a
remove instance, we should only need the client libraries.

Now we can do
```
# Start the client (will connect locally)
influx

# command within the client to show databases
> show databases;
```

In order to connect to a remote instance we will need to use:

```
influx -host <host_address> -username <host_username> -password <host_password>
```

Leaving the password blank will prompt for password

### Data Structure

The data structure of the InfluxDB is a little different than how we (I) would think of a Postgresql database. As an
example, we might have the columns "time", "power_in", "power_out" and "sensor". The last three columns - power_in,
power_out, and sensor - are either called "fields" or "tags". Tags are indexed, while fields are not. What these means
practically is that you want to use tags on values that you are searching on. You will not often be looking for a
specific value of "power_in" and that value will change constantly. However, the "sensor" fields will only have a few
specfic values that you will often search on. Perhaps the values are something like "motor1", "motor2", "psu".

Put another way, the query might often look like this: 

```
SELECT "power_in" FROM "power_info" WHERE "sensor" = "motor1";
```

Hey, that looks a lot like a POSTGRES query.

Now, that time field in the example above is a required field. It's a time-series database and it expects time series
data. There's no two ways about it - if you aren't storing time series data, then what are even doing.

In InfluxDB terms, each row in the tables is called a "point".

### In Practice

Here we will create some databases and add some data.  Creating a database and a user that only has acces to that one database.
```
influx
> CREATE DATABASE energy;
> SHOW DATABASES;
> CREATE user "energyuser" WITH PASSWORD 'password';
> SHOW USERS;
> GRANT ALL ON energy to energyuser;
```

#### Inserting data

This is where things get a little be weird. At least, significantly different than the RDMS's that I have worked with
(POSTGRES). To insert data, the format looks a little like this:

```
    measurement,(tag_set) field_set(timestamp)
    power_info,sensor=motor1 power_in=145,power_out=568
```

The "measurement" is what I would typically think of a table name. Values within a tag_set and the field_set are separated by
commas (tag1=something,tag2=something_else). tag_set and field_set are separated from each other with a space. Tagsets
and timestamps are optional. If no timestamp is provided, the database will insert one for you.

In the command below, the `;` placed on its own line is not a mistake, that is how it must be formatted to work. In practice that looks like:

```
influx --username <username> --password <password>
> USE energy;
> INSERT power_info,sensor=motor1 power_in=123,power_out=456
> ;
> SELECT * FROM power_info;
```

DANG! No messing around with models, table relations or any of that. If you want to put it in, just do it. This means we
have to be careful with how we insert data since we could programatically create a few hundread measurement on accident.
Consider the case where you mix up the measurement with the sensor fields. Opps, now each sensor has it's own table in
the database.

Check out the measurements (tables) and the tag_keys from within the influxdb-client

```
> SHOW MEASUREMENTS;
> SHOW TAG KEYS;
```

The influxdb-client is often used for bulk importing of data, but inserting data this way is very, shocking inefficient
in real time. Usually this is inserted automatically via a script. So.... that's do that!

#### Scripting Data Insertion

Let's use Python to insert some data!

```python
from influxdb imporrt InfluxDBClient(
    host='localhost',
    port=8086,
    username='energyuser',
    password='password')

line = 'power_info,sensor=motor1 power_in=123,poer_out=456'
client.write([lin], {'db': 'energy'}, 204, 'line'}
client.close()
```

We can read this back using python as well:

```python
from influxdb import InfluxDBClient
client = InfluxDBClient(host='localhost',
                        port=8086,
                        username='energyuser',
                        password='password',
                        database='energy')
result = client.query('SELECT * FROM "power_info"')
points = result.get_points(tags={'sensor': 'motor1'})
for point in points:
    print("Time: %s, power_in: %i, power_out: %i" \
          % (point['time'], point['power_in'], point['power_out']))
client.close()
```
