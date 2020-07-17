# nginx proxy

Create a nginx-proxy for development on a local machine.

```bash
docker network create nginx-proxy
docker-compose up -d
```

the default max size for file upload is 2Mb. To increase it, change `client_max_body_size` in `/vhost.d/my-app.tld`.

## Create self signed certificates

scripts from: https://stackoverflow.com/a/60516812/2112538

### root authority cert

1. create a root authority cert

   ```sh
   bash ./cert-root-create.sh
   ```

2. import the certificate authority into your Mac

   ```sh
   sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain myCA.pem
   ```

### cert for each site

create a wildcard cert for mysite.com

```sh
bash ./cert-create.sh mysite.com
```
