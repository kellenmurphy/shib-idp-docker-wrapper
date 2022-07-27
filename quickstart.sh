#!/bin/bash

./purge.sh 
./wrap.sh fetch-jetty
./wrap.sh fetch-shib
./wrap.sh install
./deploy.sh