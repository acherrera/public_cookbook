# Postgres

Postgres is a database.


## Connect to database

Use this alias so you don't have to remember the full thing every time. This assumes that your password is stored in
`~/.pgpass`

`alias psql-website-dv ='psql -h host_url -p host_port -d database_name -U user_name'`

NOTE - special characters ($, @) may need to be converted before storing them in some locations. For example, django
does not like `@`
instead you have to use `%40`. `@` => `%40`. Because strings on computers can be real weird.


## Pgpass file

This is a file that should be located at ~/.pgpass. This can have many users and connect information in file that the
psql command (and postgres programs like pgAdmin) will use to log in. An example line of the file is as follows:

    www.rds.amazon.my_database.com:5432:*:example_user:example_password
    www.rds.amazon.my_database.com:5432:*:example_user2:example_password2
    www.rds.amazon.my_database2.com:5432:*:example_user:example_password

In general, the format should be

    host_url:host_port:*:user_name:user_password

## PSQL Commands

PSQL is the builtin postgres CLI interface. After working with in exclusively for nearly a year, I highly recommend just
going to PGAdmin. It's a GUI interface that takes care of a lot of the hard parts. But, it's good to know in case you
need it.

Example of how to connect: `psql -h localhost -p 5432 -d database_name -U user_name`

Some built-in commands:
```
    \l - list databases 
    \c - connect to database
    \dn - list schema
    \q - quit the program
    \d  table_name - describe table_name table. More in depth than \dt
    \dt - describe all tables
    \e - edit previous command in editor
    \du - describe all registered users (also \du+)
```

## Trigger Management

### How to disable/enable trigger temporarily

To disable trigger

    ALTER TABLE table_name DISABLE TRIGGER trigger_name

To enable trigger 

    ALTER TABLE table_name ENABLE TRIGGER trigger_name


## Table Joins

SUPER useful. For some reason when I first starting out, this seemed much more complicated than it actually is. Probably
because there is like 5 different join types and you almost never have to think about that. Just do:

```
SELECT *
FROM table1
JOIN table2 ON table2.id = table1.t2_id
LIMIT 100;
```

For example, if you wanted to know the athlete names along with their times and the times were only tied to an athlete
via some kind of "ID". join on ID. Instead of `SELECT *` you can also specify that columns for each table as well. For
example:

```
SELECT 
table1.firstname
, table1.lastname
, table2.finish_time
FROM table1
JOIN table2 ON table2.id = table1.t2_id
LIMIT 100;
```

## Data from table based on value from second table

Using the example above, perhaps we just want to delete all the users from a table who finished below a certain time.
Well, we can first find those users using a modified version of the join query above. Then we select just the id of the
users and remove those via `where id in (...)` magic. Note that in that case the times would likely be linked so you'd
have to remove the times first and then it's just a mess. BUT you hopefully get that point.

Use two tables to narrow the selection then remove all the tables from that selection. Obviously replace SELECT COUNT(*) 
with DELETE and you've got yourself some real damage

```
SELECT COUNT(*) FROM table1
WHERE id IN
    (SELECT  table1.id
        FROM table1
        JOIN table2 ON table2.id = table1.station_id
        WHERE  table2.colval = 'some_value')
        ; 
```

## Get users in the database 

Figure out who is screwing around your database 

```sql
    select * from pg_user;
    select * from pg_stat_activity;
```

## Get the hour from timestamp

Use this to see the hour from the timestamp

    extract(hour FROM o.timestamp) = '20'


## Export query to csv file

Use this to run a command and export to a local csv file that can be used for data analytics or, you know, anything
else. **Bonus:** This also selects random points from the database for analysis as well

NOTE - this is only in psql. PDAdmin has its own button to do this.
```sql
\copy
(
    select *
    from table
    where timestamp > '2019-10-01' 
    order by random()
    limit 100
)
to '/home/tony/output.csv' DELIMITER ',' CSV HEADER;
```

# Get table and database size

Database size

```sql
SELECT pg_size_pretty( pg_database_size('dbname') );
```


Table size
```sql
SELECT pg_size_pretty( pg_total_relation_size('tablename') );
```

## Select Duplicate Rows

Basically Magic - this goes through and finds where the values for firstname, lastname are duplicated

```sql
SELECT * FROM
  (SELECT *, count(*)
  OVER
    (PARTITION BY
      firstname,
      lastname
    ) AS count
  FROM people) tableWithCount
  WHERE tableWithCount.count > 1;
```


## Remove duplicate rows

Use for completely duplicated rows

```sql
SELECT DISTINCT * FROM people;
```

Use for rows that may be only partially duplicated

```sql
SELECT DISTINCT ON (firstname, lastname) * FROM people
```

Now to actually remove them. Using an alias for the subquery because it makes life easier

```sql
WITH unq AS
    (SELECT DISTINCT ON (firstname, lastname) * FROM people)
DELETE FROM people WHERE people.id NOT IN (SELECT id FROM unq);
```

## Users

### Create user with read-only permission 

```sql
CREATE USER user WITH ENCRYPTED PASSWORD 'password';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO user;
```

## Inserting data to other table

This will select data from one table and insert it into another. Use only the "select" part to see the values that will
be moved over

```sql
    insert into table2
    select 
    req1
    , req2
    , req3
    from table1
    where timestamp > '2020-01-01'and timestamp < '2020-01-31'
    and some_val > 100;
```


## Nulling values

Used in cases where values are bad and we just want them to go away. Usually a quick fix for a bigger issue.

```sql
UPDATE table1 
SET some_column = Null 
WHERE some_column > 100;
```

Similar to the above but we are using a join to only null values within a specified class that have out of bounds values
```sql
update table1
set some_column = Null
where id in
(
    select o.id 
    from table1 t1
    join table2 t2 on t2.id = t1.id
    where some_column > 100
    and t2.class = 'class_name'
);
```




## Magic Database in Docker

This is will get a docker database running locally without a bunch of configuration and makes it real easy to remove as
well. In this case it will also add the `postgis` extension as an example of how to add extensions.

```
function magicdb
    set DB_HOST 0.0.0.0
    set DB_NAME database_name
    set DB_PORT 5433
    set DB_USER postgres
    set DB_PASSWORD mysecretpassword
    sudo docker pull mdillon/postgis
    sudo docker run -e POSTGRES_PASSWORD=mysecretpassword -p 5433:5432 -d mdillon/postgis
    echo 'To stop container, run: "docker kill (docker ps --latest --quiet)"'
    echo 'Waiting 2 seconds for database to calm down'
    sleep 5
    psql -h localhost -p 5433 -U $DB_USER -c "CREATE DATABASE $DB_NAME;"
    sleep 1
    psql -h localhost -p 5433 -U $DB_USER -d $DB_NAME -c "CREATE EXTENSION postgis;"
end
```
