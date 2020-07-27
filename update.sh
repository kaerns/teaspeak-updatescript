#!/bin/bash

branch=""
requesturl=
version=
environment=

request_version() {
    echo "# Getting version..."
    version=$(curl -s -S -k https://repo.teaspeak.de/server/linux/amd64${branch}/latest)
	echo "# Newest version is ${version}"
}

check_env() {
    if [ `getconf LONG_BIT` = "64" ]
    then
        echo "# Detected an 64 bit environment"
	    environment="amd64"
    else
	    echo "# Detected an 32 bit environment"
	    environment="x86"
    fi
}

update_teaspeak() {

    request_version
    check_env

    requesturl="https://repo.teaspeak.de/server/linux/${environment}${branch}/TeaSpeak-${version}.tar.gz"

    echo "# Downloading from ${requesturl}"
    curl -s -S "$requesturl" -o updatefile.tar.gz

    echo "# Backing up config and database"
    cp config.yml config.yml.old
    cp TeaData.sqlite TeaData.sqlite.old

    echo "# Unpacking and removing .tar.gz"
    tar -xzf updatefile.tar.gz
    rm updatefile.tar.gz

    echo "# Making scripts executable"
    chmod u+x *.sh

    echo "# TeaSpeak should be now be updated to ${version}"
}


while [[ $# -gt 0 ]] # loop as long as there are arguments left
do
    key="$1" # extract current argument
    case $key in

    -b|--beta) # optimized beta version
        echo "# Using the optimized beta branch"
        branch="_optimized"
        shift
    ;;

    -h|--help) # help
        cat << EOF
# TeaSpeak Update Script (https://github.com/essemX/teaspeak-updatescript)
# Maintained by essemX (https://github.com/essemX)
# Contributers: 
	Coolguy3289 (https://github.com/Coolguy3289)

Usage: update.sh [-b|--beta]
Options: 
	-b, --beta     use the optimized build
	-h, --help     display this message and exit
EOF
        shift
        exit 0 # script did its job
    ;;

    *) # default/unknown parameter
        echo "# Invalid argument(s). Use --help for help."
        shift
        exit 127 # command not found
    ;;

esac
done

update_teaspeak
