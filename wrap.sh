#!/bin/bash
# Wrap shell script from @iay/shibboleth-idp-docker with our VERSIONS and execute

files=("VERSIONS" "install-idp") 
mkdir ./tmp
for file in ${files[@]}; do
    cp ./shibboleth-idp-docker/$file ./tmp/$file-ORIG
    cp ./$file ./shibboleth-idp-docker/$file
done


echo "executing: $1 from @iay/shibboleth-idp-docker..."
if test -f "./shibboleth-idp-docker/$1"; then
    cd ./shibboleth-idp-docker/
    ./$1
    cd ..
fi

for file in ${files[@]}; do
    cp ./tmp/$file-ORIG ./shibboleth-idp-docker/$file
done
rm -rf ./tmp