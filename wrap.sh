#!/bin/bash
# Wrap shell script from @iay/shibboleth-idp-docker with our VERSIONS and execute

TMPDIR=./tmp
files=(`ls ./base-repo-overlay`)
mkdir $TMPDIR
for file in ${files[@]}; do
    cp ./shibboleth-idp-docker/$file $TMPDIR/$file-ORIG
    cp ./base-repo-overlay/$file ./shibboleth-idp-docker/$file
done


echo "executing: $1 from @iay/shibboleth-idp-docker..."
if test -f "./shibboleth-idp-docker/$1"; then
    cd ./shibboleth-idp-docker/
    ./$1
    cd ..
fi

for file in ${files[@]}; do
    cp $TMPDIR/$file-ORIG ./shibboleth-idp-docker/$file
done
rm -rf $TMPDIR