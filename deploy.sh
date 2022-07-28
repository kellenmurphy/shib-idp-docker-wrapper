#!/bin/bash

if [ -e './idp-overlay/shibboleth-idp' ]; then
    cp -r ./idp-overlay/shibboleth-idp/* ./shibboleth-idp-docker/shibboleth-idp
fi
if [ ! -e './idp-overlay/shibboleth-idp/credentials/idp-userfacing.p12' ]; then
    ./wrap.sh gen-selfsigned-cert
fi
./wrap.sh build
./wrap.sh run