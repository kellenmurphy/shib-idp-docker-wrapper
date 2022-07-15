#!/bin/bash
# Wrap shell script from @iay/shibboleth-idp-docker with our VERSIONS and execute

mkdir ./tmp
cp ./shibboleth-idp-docker/VERSIONS ./tmp/VERSIONS-ORIG
cp ./VERSIONS ./shibboleth-idp-docker/VERSIONS
echo "executing: $1 from @iay/shibboleth-idp-docker..."
if test -f "./shibboleth-idp-docker/$1"; then
    ./shibboleth-idp-docker/$1
fi
cp ./tmp/VERSIONS-ORIG ./shibboleth-idp-docker/VERSIONS
rm -rf ./tmp