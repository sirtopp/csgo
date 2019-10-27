#!/bin/bash

REPO_BASE=

echo "This will install CS:GO Dedicated Server"

if [ -z "${STEAM_SERVER_TOKEN}" ]
then
  echo "!!! Missing STEAM_SERVER_TOKEN env variable!"
  echo "To obtain one go to: https://steamcommunity.com/dev/managegameservers"
  echo "Set in in calling script using export:"
  echo
  echo "export STEAM_SERVER_TOKEN=your-token"
  echo "./call-this-script"
  exit 1
fi





apt-get install --no-install-recommends -y lib32gcc1 lib32stdc++6 ca-certificates

useradd -m steam
mkdir /csgo
chown steam:steam /csgo
sudo su - steam
mkdir ~/Steam && cd ~/Steam

echo "export RCON_PASSWORD='${RCON_PASSWORD:-}'" >> ~/.profile
echo "export STEAM_SERVER_TOKEN='${STEAM_SERVER_TOKEN}'" >> ~/.profile


curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
# ./steamcmd.sh +login anonymous +force_install_dir /csgo +app_update 740 validate +quit