# nginx proxy

```bash
docker network create nginx-proxy
docker-compose up -d
```

create-ssl-certificate --hostname myproject --domain local

La taille d'upload maximale est de 2Mb. Pour l'augmenter il faut modifier `client_max_body_size` dans `/vhost.d/my-app.tld`.
