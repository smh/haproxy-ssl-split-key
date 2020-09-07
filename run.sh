#!/bin/bash

./genkeys.sh
sed -e "s,\${cwd},$PWD,g" haproxy.tmpl.cfg > haproxy.cfg
haproxy -f $PWD/haproxy.cfg
