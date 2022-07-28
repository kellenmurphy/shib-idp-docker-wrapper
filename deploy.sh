#!/bin/bash

if [ -e './idp-overlay/shibboleth-idp' ]; then
    cp -rp ./idp-overlay/shibboleth-idp/* ./shibboleth-idp-docker/shibboleth-idp
fi
if [ ! -e './idp-overlay/shibboleth-idp/credentials/idp-userfacing.p12' ]; then

    if [ -e ./base-repo-overlay/cert-env ]; then
        source ./base-repo-overlay/cert-env
    fi

    openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -keyout userfacing.key -out userfacing.crt -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANISATION/OU=$ORGANISATIONAL_UNIT/CN=$COMMON_NAME" -addext "subjectAltName = DNS:$HOST"

    openssl pkcs12 -export -out idp-userfacing.p12 -inkey userfacing.key -in userfacing.crt -passout pass:$UFPASS

    mv idp-userfacing.p12 ./idp-overlay/shibboleth-idp/credentials

    rm userfacing.key
    rm userfacing.crt

fi
./wrap.sh build
./wrap.sh run