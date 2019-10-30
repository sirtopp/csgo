# csgo
CS:GO DS install script targeted for Debian-like distributions.

# Usage

You can automate installation process by using simple server installation script:

```
#!/bin/sh

export STEAM_SERVER_TOKEN="....."
export RCONN_PASSWORD="your-rcon-password"
export SERVER_PASSWORD="your-server-password"
SERVER_DOMAIN='your-server-domain'
# I use Vultr VPSes, another cloud providers in the future.
export VULTR_API_KEY='....'
# I use DuckDNS to provide DNS, another providers in the future.
export DUCKDNS_KEY='....'


curl -sqL "https://raw.githubusercontent.com/sirtopp/csgo/master/isntall.sh" | bash
```
