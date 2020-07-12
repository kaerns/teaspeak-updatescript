#!/bin/bash
echo "# TeaSpeak Updater by essemX (github.com/essemX/teaspeak-updatescript)"
echo "# Updated by Coolguy3289 (https://github.com/Coolguy3289)"

branch=
requesturl=
version=

update_teaspeak() {
if [ `getconf LONG_BIT` = "64" ]
then
        echo "# Detected an 64 bit environment"
                echo "# Getting version..."
                version=$(curl -s -S -k https://repo.teaspeak.de/server/linux/amd64${branch}/latest)
                echo "# Newest version is ${version}"
        requesturl="https://repo.teaspeak.de/server/linux/amd64${branch}/TeaSpeak-${version}.tar.gz"
else
        echo "# Detected an 32 bit environment"
                echo "# Getting version..."
                version=$(curl -s -S -k https://repo.teaspeak.de/server/linux/x86${branch}/latest)
                echo "# Newest version is ${version}"
        requesturl="https://repo.teaspeak.de/server/linux/x86${branch}/TeaSpeak-${version}.tar.gz"
fi
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


}

if [ "$1" != "" ]; then
    if [ "$1" = "beta"]; then
      echo "# Grabbing latest beta version"
      branch="_optimized"
      update_teaspeak
    else
      echo "# This is not a valid argument. You can run the file with no argument for the stable version, or with the beta argument to grab the latest beta version."
    fi
else
    echo "# Grabbing latest stable version"
    branch=""
    update_teaspeak
fi
