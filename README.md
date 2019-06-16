# Literature list generator

[![CircleCI](https://circleci.com/gh/woarewe/literature-list-generator.svg?style=svg)](https://circleci.com/gh/woarewe/literature-list-generator)

# How to configure and deploy this app via docker
### Before: Go to your server via ssh and install docker

- Pull nginx and postgres official images and app image

```shell
docker pull postgres
docker pull nginx
docker pull <app image>
```

- Create postgres container

```shell
docker container create \
--publish 5432:5432 \
--volume <local volume>:/var/lib/postgresql/data
--env POSTGRES_USER=literature_list_generator \
POSTGRES_DB=literature_list_generator_production \
POSTGRES_PASSWORD=<db password> \
postgres
```

- Create app container

```shell
docker container create \
--publish 3000:3000 \
--env \
RAILS_ENV=production \
RACK_ENV=production\
ROBERT_LEGAL_DATABASE_HOST=postgres \
ROBERT_LEGAL_DATABASE_PASSWORD=<db password> \
--link <db container>:postgres \
<app image>
```

- Start containers

```shell
docker container start <app container id>
docker container start <db container id>
```
