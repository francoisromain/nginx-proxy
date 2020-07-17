#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Please supply a subdomain to create a certificate for"
  echo "e.g. www.mysite.com"
  exit
fi

if [ ! -f myCA.pem ]; then
  echo 'Please run "create_root_cert_and_key.sh" first, and try again!'
  exit
fi

NAME=$1
######################
# Create CA-signed certs
######################

# Generate a private key
openssl genrsa -out $NAME.key 2048

# Create a certificate-signing request
openssl req -new -key $NAME.key -out $NAME.csr

# Create a config file for the extensions
cat >$NAME.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $NAME # Be sure to include the domain name here because Common Name is not so commonly honoured by itself
DNS.2 = api.$NAME # Optionally, add additional domains (I've added a subdomain here)
EOF

# Create the signed certificate
openssl x509 -req -in $NAME.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial \
  -out $NAME.crt -days 825 -sha256 -extfile $NAME.ext
