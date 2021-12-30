# Gobuster

Find directories of a website. This requires a wordlist to make it work.


Example command `gobuster dir -u http://<ip>:<port> -w <word list location>

```
GoBuster    flag Description
-e          Print the full URLs in your console
-u          The target URL
-w          Path to your wordlist
-U and -P   Username and Password for Basic Auth
-p <x>      Proxy to use for requests
-c <http cookies> Specify a cookie for simulating your auth
```

