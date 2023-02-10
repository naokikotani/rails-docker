# README

## build

```
docker compose build
```

## dbセットアップ

```
docker-compose run web rake db:create db:migrate
```

もしくは

```
docker compose run --rm web bin/setup
```


## docker compose の起動

```
docker compose up
```

## docker compose の停止

```
docker compose down
```