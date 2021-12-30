# NMAP

Network mapping tool. Very good. Can be used casually to see if a website is running - this is something that I use it
for often when making new website to at very least check that the port is open. It can also be used to find
vulnerabilities.


## Basics Flags

In case `nmap --help` is too difficult.
```
    -h          # help
    -sS         # Secret scan
    -sU         # UDP scan
    -O          # Find operating system
    -sV         # scan version
    -v          # Verbose
    -vv         # Double verbose
    -oX         # XML output
    -A          # Aggressive scan
    -T5         # Max timeout (insane mode)
    -p XX       # Specify port XX
    -F          # Fast scan (most common only)
    -p-         # Scan all ports
    --script    # Run scripts
    -Pn         # Run without pinging
```

## Vulnerability Mapping

Nmap also has scripts that can run and find vulnerabilities. Example:

```
    nmap -sV -sC -script vuln blue.nmap XX.XX.XXX.XXX
```

Using the `-sV` flag will attempt to find the version of services that are running.
