#!/bin/bash

if [ -e './shibboleth-idp' ]; then
    cp -r ./shibboleth-idp/* ./shibboleth-idp-docker/shibboleth-idp
fi
if [ ! -e './shibboleth-idp/credentials/idp-userfacing.p12' ]; then
    ./wrap.sh gen-selfsigned-cert
fi
./wrap.sh build
./wrap.sh run