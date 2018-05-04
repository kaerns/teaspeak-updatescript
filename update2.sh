#!/bin/bash
echo "# TeaSpeak Updater by essemX (github.com/essemX/teaspeak-updatescript)"
echo "# Getting version..."
version=$(curl -s -S -k https://repo.teaspeak.de/latest)
echo "# Newest version is ${version}"
requesturl="https://repo.teaspeak.de/server/linux/x64/TeaSpeak-${version}.tar.gz"
echo "# Downloading ${requesturl}"
curl -s -S "$requesturl" -o updatefile.tar.gz
echo "# Unzipping and removing updatefile.tar.gz"
tar -xzf updatefile.tar.gz
rm updatefile.tar.gz
echo "# TeaSpeak should be now updated to ${version}"
