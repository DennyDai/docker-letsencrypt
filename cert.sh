#!/bin/bash
path=$( cd "$(dirname "$BASH_SOURCE[0]")" ;pwd -P )
echo -n "Your Domain:"
read domain
docker-compose up -d
openssl genrsa 4096 > $path/certs/$domain.key
openssl req -new -sha256 -key $path/certs/$domain.key -subj "/CN=$domain" > $path/certs/$domain.csr
python $path/acme_tiny.py --account-key account.key --csr $path/certs/$domain.csr --acme-dir $path/www/ > $path/certs/pre.$domain.crt
wget -O - https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > $path/certs/letsencrypt-intermediate.pem
cat $path/certs/pre.$domain.crt $path/certs/letsencrypt-intermediate.pem > $path/certs/$domain.crt
rm $path/certs/letsencrypt-intermediate.pem
rm $path/certs/pre.$domain.crt
rm $path/certs/$domain.csr
docker-compose down
