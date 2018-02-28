#!/bin/bash
echo "# getting version"
versionurl="latest"
if [ $# -ne 0 ]
then
if [ "$1" = "build" ]
then
versionurl="buildIndex.txt"
else
echo "# ony build is an valid agument"
exit 1
fi
fi
echo "# version url ${versionurl}"
version=$(curl -k https://repro.teaspeak.de/${versionurl})
echo "# newest version is ${version}"
requesturl="https://repro.teaspeak.de/server/linux/x64/TeaSpeak-${version}.tar.gz"
echo "# requesting from ${requesturl}"
wget "$requesturl"
filename="TeaSpeak-${version}.tar.gz"
echo "# unzip and removing $filename"
tar -xzf $filename
rm $filename
echo "# now updated to ${version}"
