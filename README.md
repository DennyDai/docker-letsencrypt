# Docker-LetsEncrypt

Easily get your "Let's Encrypt" SSL Certificates

**PLEASE READ THE SOURCE CODE! YOU MUST TRUST IT WITH YOUR PRIVATE KEYS!**

## How to use this script
**You must have [docker-compose](https://github.com/docker/compose/blob/master/docs/install.md) installed first. Then follow the steps below.**
### Step 1: Create a Let's Encrypt account private key (if you haven't already)

You must have a public key registered with Let's Encrypt and sign your requests
with the corresponding private key. If you don't understand what I just said,
this script likely isn't for you! Please use the official Let's Encrypt
[client](https://github.com/letsencrypt/letsencrypt).

```
openssl genrsa 4096 > account.key
```
### Step 2: Copy account.key to docker-letsencrypt/
You know how to do it. :)
### Step 3: Create Your key and Cert
```
sh cert.sh
```
Then type your domain and press Enter.

Wait for a moment, and you can find your key and cert in docker-lesencrypt/certs/
####Have fun :)