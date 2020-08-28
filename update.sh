#!/bin/bash
#
#    TeaSpeak Update Script (https://github.com/kaerns/teaspeak-updatescript)
#    Copyright (C) 2020 essemX (https://github.com/kaerns)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#

branch=""
request_url=
version=
environment=
force=false
autostart=false

check_curl() {
    if [ ! -x "$(which curl)" ]; then
        echo "# Could not find curl, which is required for this script."
        exit 1
    fi
}

request_version() {
    echo "# Getting version..."
    version=$(curl -s -S -k https://repo.teaspeak.de/server/linux/amd64${branch}/latest)
	echo "# Newest version is ${version}"
}

check_env() {
    # read os long bit
    if [ `getconf LONG_BIT` = "64" ]; then
        echo "# Detected an 64 bit environment"
	    environment="amd64"
    else
	    echo "# Detected an 32 bit environment"
	    environment="x86"
    fi
}

read_version() {
    if [ -r "buildVersion.txt" ]; then
        # extract current version
        active_version=$(tail -n 1 "buildVersion.txt" | tr "\"" "\n" | head -n 4 | tail -n 1)
        echo "# Installed version ${active_version}"

        if [[ "$active_version" == "$version" ]]; then
            if ! $force ; then
                echo "# Update aborted. Use the --force parameter to update anyway."
                exit 0
            fi        
        fi
    fi
}

stop_server() {
    if [ -x "teastart.sh" ]; then
        # check for returned status code
        if ./teastart.sh status > /dev/null ; then
            echo "# Server is running; stopping now..."
            ./teastart.sh stop
        fi
    fi
}

start_server() {
    if ! $autostart ; then
        return
    fi
    echo "# Starting teaspeak server via './teastart.sh start'"
    ./teastart.sh start
}

update_teaspeak() {
    check_curl
    request_version
    read_version
    check_env
    stop_server

    request_url="https://repo.teaspeak.de/server/linux/${environment}${branch}/TeaSpeak-${version}.tar.gz"

    echo "# Downloading from ${request_url}"
    curl -s -S "$request_url" -o updatefile.tar.gz

    echo "# Backing up config and database"
    cp config.yml config.yml.old
    cp TeaData.sqlite TeaData.sqlite.old

    echo "# Unpacking and removing .tar.gz"
    tar -xzf updatefile.tar.gz
    rm updatefile.tar.gz

    echo "# Making scripts executable"
    chmod u+x *.sh

    start_server

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
# TeaSpeak Update Script (https://github.com/kaerns/teaspeak-updatescript)
# Maintained by essemX (https://github.com/kaerns)
# Contributers: 
	Coolguy3289 (https://github.com/Coolguy3289)

Usage: update.sh [-b|--beta]
Options: 
    -b, --beta     use the optimized build
    -h, --help     display this message and exit
    -f, --force    enforce the update even if the newest version is already installed
    -s, --start    starts the server again after the update (uses teastart.sh start)
EOF
        shift
        exit 0 # script did its job
    ;;

    -f|--force) # force update
        force=true    
        shift
    ;;
    -s|--start) # autostart after update
        autostart=true
        shift
    ;;

    *) # default/unknown parameter
        echo "# Invalid argument(s). Use --help for help."
        shift
        exit 1 # parameter not found
    ;;

esac
done

update_teaspeak
