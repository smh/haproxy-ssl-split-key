#!/bin/bash

CERT_PATH=certs

# root ca key/cert
openssl genrsa -des3 -out ssl-root-ca.key -passout pass:password
openssl req -x509 -new -nodes -key ssl-root-ca.key -subj "/C=US/ST=CA/O=Test Org, Inc./CN=ROOT CA" -sha256 -days 1024 -out $CERT_PATH/ssl-root-ca.pem -passin pass:password

# certficiate
openssl genrsa -out $CERT_PATH/ssl-cert.pem.key -passout pass:password

openssl req -new -sha256 -key $CERT_PATH/ssl-cert.pem.key -subj "/C=US/ST=CA/O=Test Org, Inc./CN=localhost" -out ssl-cert.csr -passin pass:password
openssl x509 -req -in ssl-cert.csr -CA $CERT_PATH/ssl-root-ca.pem -CAkey ssl-root-ca.key -CAcreateserial -out $CERT_PATH/ssl-cert.pem -days 500 -sha256 -passin pass:password

cat $CERT_PATH/ssl-cert.pem.key $CERT_PATH/ssl-cert.pem $CERT_PATH/ssl-root-ca.pem > $CERT_PATH/ssl-cert-with-key.pem
