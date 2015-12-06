#!/bin/bash
path=$(pwd)
echo -n "Your Domain:"
read domain
docker-compose up -d
cd $path/certs/
openssl genrsa 4096 > $path/certs/$domain.key
openssl req -new -sha256 -key $domain.key -subj "/CN=$domain" > $path/certs/$domain.csr
cd $path/
python $path/acme_tiny.py --account-key account.key --csr $path/certs/$domain.csr --acme-dir $path/www/ > $path/certs/$domain.crt
wget -O - https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem > $path/certs/letsencrypt-intermediate.pem
cat $path/certs/$domain.crt $path/certs/letsencrypt-intermediate.pem > $path/certs/$domain.pem
rm $path/certs/letsencrypt-intermediate.pem
rm $path/certs/$domain.crt
cat $path/certs/$domain.pem > $path/certs/$domain.crt
rm $path/certs/$domain.pem
rm $path/certs/$domain.csr
docker-compose stop