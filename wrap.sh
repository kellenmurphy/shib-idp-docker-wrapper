#!/bin/bash
# Wrap shell script from @iay/shibboleth-idp-docker with our VERSIONS and execute

TMPDIR=./tmp
files=(`ls ./base-repo-overlay`)
if [ ! -e $TMPDIR ]; then
    mkdir $TMPDIR
fi

for file in ${files[@]}; do
    if [ -e ./shibboleth-idp-docker/$file ]; then
        cp ./shibboleth-idp-docker/$file $TMPDIR/$file-ORIG
    fi
    cp ./base-repo-overlay/$file ./shibboleth-idp-docker/$file
done

echo "executing: $1 from @iay/shibboleth-idp-docker..."
if test -f "./shibboleth-idp-docker/$1"; then
    cd ./shibboleth-idp-docker/
    ./$@
    cd ..
fi

for file in ${files[@]}; do
    if [ -e ./shibboleth-idp-docker/$file ]; then 
        rm -rf ./shibboleth-idp-docker/$file
    fi
    if [ -e $TMPDIR/$file-ORIG ]; then
        cp $TMPDIR/$file-ORIG ./shibboleth-idp-docker/$file
    fi
done

if [ -e $TMPDIR ]; then
    rm -rf $TMPDIR
fi