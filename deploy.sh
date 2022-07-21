#!/bin/bash

if [ -e './shibboleth-idp' ]; then
    cp -r ./shibboleth-idp/* ./shibboleth-idp-docker/shibboleth-idp
fi
if [ ! -e './shibboleth-idp/credentials' ]; then
    ./wrap.sh gen-selfsigned-cert
fi
./wrap.sh build
./wrap.sh run