#!/bin/bash

./purge.sh 
./wrap.sh terminate
./wrap.sh fetch-jetty
./wrap.sh fetch-shib
./wrap.sh install
./wrap.sh gen-selfsigned-cert
./wrap.sh build
./wrap.sh run