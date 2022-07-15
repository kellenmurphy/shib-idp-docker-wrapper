#!/bin/bash
# clean up downloaded files and purge images

files=("fetched-*" "fetched" "jetty-dist" "shibboleth-idp" "logs") 
for file in ${files[@]}; do
    rm -rf ./shibboleth-idp-docker/$file
done