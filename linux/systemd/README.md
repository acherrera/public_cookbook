# Python Script as a Service (Systemctl / systemd)

This is very useful if you have a script running that needs to run ALL THE TIME and it also allows you to specify
dependencies

First we need a python script. We'll do something simple for the demo. Name this file `test.py`

```
    import time
    from datetime import datetime
    filepath = "/home/<username>/timestamp.txt"
    while True:
        with open(filepath, "a") as f:
            f.write("The current timestamp is: " + str(datetime.now()))
            f.close()
        time.sleep(10)
```

Next, we need to define the system job. This file must live in `/etc/systemd/system/`. We'll call it `test.service`
since we are running the `test.py` file. The full path to this file will be `/etc/systemd/system/test.service`

```
[Unit]
Description=My test service
After=multi-user.target

[Service]
Type=simple
Restart=always
ExecStart=/usr/bin/python3 /home/<username>/test.py

[Install]
WantedBy=multi-user.target

```

Note that if the python packages are not installed system-wide (IE: on a virtual environment) you will need to choose a
different `ExecStart` path.

## Running and Enabling

The system jobs can be started and enabled with: 

```
sudo systemctl daemon-reload
sudo systemctl enable test.service
sudo systemctl start test.service
```

Enabling the job will make sure that service is run according to the definition (in this case - start when the system
reboots) and the `start` will actually start the job immediately.


Note that the file is run from the root directory since that is where systemd jobs live. Which means any relative paths
will be relative to the root directory. So use absolute paths when running systemd/ctl jobs. 

## Stop Restart and Status

Extra commands to help you out along the way:

```
sudo systemctl stop name_of_your_service
sudo systemctl restart name_of_your_service
sudo systemctl status name_of_your_service

```

## Diagnosing

Like all good project - anything worth doing is worth doing wrong. In this case, the job kept failing and all the status
report showed was that it failed with exid_status = 2. Not helpful. I found the solution [here](https://stackoverflow.com/questions/48985184/what-is-wrong-with-my-systemd-service)

The command for this is:

```
    journalctl -xfe -u <service_name>
```

Which in my case "service_name" was `hubitat_logging`. This showed the output of the run job and, look at that!
