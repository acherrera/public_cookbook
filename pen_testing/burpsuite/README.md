# Burpsuite

Immensely useful. Not only for attacking website, could be very useful for API development and debugging as you can
directly see what is being sent back and forth.


## Configuration to use the web

The basics of this are - install a proxy service to route traffice through burpsuite and then add burpsuite's CA
certificate to the web browser so that everything isn't flagged as suspicious.

Need to install FoxyProxy for Firefox and route traffic through 127.0.0.1:8080

- Install foxyProxy
- add 127.0.0.1:8080 as the proxy to use

Now need to go in and get a certification so burpsuite can run correctly

- go to 127.0.0.1:8080
- click "CA certificate" at top right
- go to "settings" in Firefox and search for "Certificates"
- "View Certificates" > "Authorities" > "import"
- find certificate

Now, when you make a request, burpsuite will capture it. Turn off interception to use the internet as intended.
