#!/bin/bash

# Installer for TeamSpeak 3 Free version

set -e

TS3_SRC='https://files.teamspeak-services.com/releases/server/3.11.0/teamspeak3-server_linux_amd64-3.11.0.tar.bz2'
TS3_SRC_SHA256='18c63ed4a3dc7422e677cbbc335e8cbcbb27acd569e9f2e1ce86e09642c81aa2'

curl "https://www.duckdns.org/update?domains=ferajna-ts3&token=${DUCKDNS_KEY}"

useradd -m teamspeak
cd /home/teamspeak
su teamspeak

wget "${TS3_SRC}"
FILENAME=$(ls teamspeak3-*)
echo "${TS3_SRC_SHA256} ${FILENAME}" | sha256sum --check


tar -jxvf "${FILENAME}"
rm "${FILE}"

cd teamspeak3-server_linux_amd64
touch .ts3server_license_accepted


wget 'https://raw.githubusercontent.com/sirtopp/csgo/master/ts3server.ini'
./ts3server_minimal_runscript.sh inifile=ts3server.ini &


# token=OsSf8rWi0jhIOebEFetT5zR0KUdMuuwSkaCytmeL
# loginname= "serveradmin", password= "JcvRS3WI"