# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

## プロジェット作成

1. `docker-compose run --rm back rails new . --api --database=mysql --skip-test --force`

## プロジェクトスタート

1. `docker-compose build`

2. `aws s3 mb s3://anima --endpoint-url=http://localhost:4566`
