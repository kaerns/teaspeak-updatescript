#!/bin/bash
echo "# TeaSpeak Updater by essemX (github.com/essemX/teaspeak-updatescript)"
echo "# Getting version..."
version=$(curl -s -S -k https://repo.teaspeak.de/latest)
echo "# Newest version is ${version}"
requesturl="https://repo.teaspeak.de/server/linux/x64/TeaSpeak-${version}.tar.g$
echo "# Downloading ${requesturl}"
curl -s -S "$requesturl" -o updatefile.tar.gz
echo "# Backing up config and database"
cp config.yml config.yml.old
cp TeaData.sqlite TeaData.sqlite.old
echo "# Unpacking and removing .tar.gz"
tar -xzf updatefile.tar.gz
rm updatefile.tar.gz
echo "# Making scripts executable"
chmod u+x *.sh
echo "# TeaSpeak should be now updated to ${version}"
