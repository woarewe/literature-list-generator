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

- Create docker volumes:
  - For postgres data:
  ```shell
  docker volume create --name postgres_data
  docker volume create --name literate_list_generator_production_public
  ```
  
- Create postgres container

```shell
docker container create --publish 5432:5432 --volume postgres_data:/var/lib/postgresql/data --env POSTGRES_USER=literature_list_generator --env POSTGRES_DB=literature_list_generator_production --env POSTGRES_PASSWORD=Zhur999550505 postgres
```

- Create app container

```shell
# Start db container before
docker container start <db container id>

docker container create --volume literate_list_generator_production_public:/app/public --publish 3000:3000 --env RAILS_ENV=production --env RACK_ENV=production --env ROBERT_LEGAL_DATABASE_HOST=postgres --env ROBERT_LEGAL_DATABASE_PASSWORD=<db password> --link <db container>:postgres <app image>
```

- Create nginx container 

```shell
# Start app container before
docker container start <app container id>

docker container create --publish 80:80 --volume <path to nginx.conf>:/etc/nginx/conf.d/default.conf --link <app container>:app --volume literate_list_generator_production_public:/usr/share/nginx/html:ro nginx
```

- Start nginx container

```shell
docker container start <nginx container>
```
