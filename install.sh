#!/bin/bash

DOWNLOAD_BASE_URL="https://github.com/sirtopp/csgo/raw/master"
PACKAGE_URL="https://github.com/sirtopp/csgo/archive/master.zip"
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

apt-get install --no-install-recommends -y lib32gcc1 lib32stdc++6 ca-certificates unzip

curl -Lo master.zip ${PACKAGE_URL}
unzip master.zip


echo "Creating user: ${CS_USER}"
useradd -m steam
mkdir -p ${CS_DIR}
chown ${CS_USER}:${CS_USER} ${CS_DIR}

pushd csgo-master
source ./pre-install.sh
popd

sudo -u ${CS_USER} -i <<USERSCRIPT
	mkdir ~/Steam && cd ~/Steam
	curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
	./steamcmd.sh +login anonymous +force_install_dir /csgo +app_update 740 validate +quit
USERSCRIPT

mv  "csgo-master/cfg/server.cfg" "${CS_DIR}/csgo/cfg/server.cfg"
mv  "csgo-master/cfg/autoexec.cfg" "${CS_DIR}/csgo/cfg/autoexec.cfg"
chown ${CS_USER}:${CS_USER} "${CS_DIR}/csgo/cfg"

cat << AUTOEXEC_CFG >> "${CS_DIR}/csgo/cfg/autoexec.cfg"

hostname "${SERVER_NAME}"
rcon_password "${RCON_PASSWORD}"
sv_password "${SERVER_PASSWORD}"
sv_setsteamaccount "${STEAM_SERVER_TOKEN}"
AUTOEXEC_CFG

cd csgo-master
cp csgo-ds /etc/init.d/ && chmod +x /etc/init.d/csgo-ds
source ./post-install.sh