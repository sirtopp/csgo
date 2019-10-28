#!/bin/bash

REPO_BASE=
CS_DIR=/csgo
CS_USER=steam

echo "This will install CS:GO Dedicated Server"
SERVER_NAME=${SERVER_NAME:-Default Server (change in boot script)}

if [ -z "${STEAM_SERVER_TOKEN}" ]
then
  echo "!!! Missing STEAM_SERVER_TOKEN env variable!"
  echo "To obtain one go to: https://steamcommunity.com/dev/managegameservers"
  echo "Set in in calling script using export:"
  echo
  echo "export STEAM_SERVER_TOKEN=your-token"
  echo "./call-this-script"
  exit 1
else
  echo "STEAM_SERVER_TOKEN: ${STEAM_SERVER_TOKEN}"
fi





apt-get install --no-install-recommends -y lib32gcc1 lib32stdc++6 ca-certificates
echo "Creating user: ${CS_USER}"
useradd -m steam
mkdir -p ${CS_DIR}
chown ${CS_USER}:${CS_USER} ${CS_DIR}
sudo -u ${CS_USER} -i <<USERSCRIPT
	mkdir ~/Steam && cd ~/Steam
	curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
	./steamcmd.sh +login anonymous +force_install_dir /csgo +app_update 740 validate +quit
USERSCRIPT

#echo "export RCON_PASSWORD='${RCON_PASSWORD:-}'" >> ~/.profile
#echo "export STEAM_SERVER_TOKEN='${STEAM_SERVER_TOKEN}'" >> ~/.profile
#echo "export SERVER_PASSWORD='${SERVER_PASSWORD}'" >> ~/.profile

cat << END_OF_CFG > "${CS_DIR}/csgo/cfg/server.cfg"
hostname "${SERVER_NAME}"
rcon_password "${RCON_PASSWORD}"
sv_password "${SERVER_PASSWORD}"
sv_setsteamaccount "${STEAM_SERVER_TOKEN}"
sv_lan 0
sv_cheats 0
END_OF_CFG

echo "    > Updating DNS (${SERVER_DOMAIN})..."

curl -s "https://www.duckdns.org/update?domains=${SERVER_DOMAIN}&token=${DUCKDNS_KEY}"