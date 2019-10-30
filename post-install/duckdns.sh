
if [ -n "${DUCKDNS_KEY}" ]
then
        echo "    > Updating DNS (${SERVER_DOMAIN})...":q
        curl -s "https://www.duckdns.org/update?domains=${SERVER_DOMAIN}&token=${DUCKDNS_KEY}"
fi
