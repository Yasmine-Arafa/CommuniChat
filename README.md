# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



docker-compose up -d

docker-compose exec web bundle exec rails db:create

docker-compose exec web bundle exec rails db:migrate




# README

This README documents the necessary steps to get this Rails application up and running using Docker.

## Ruby version

Specify the Ruby version your application is using.

## System dependencies

List any system dependencies that are needed to run your application.

## Configuration

Describe any configuration that needs to be done before running the application.

## Database creation and initialization

This application uses Docker to create and initialize the database. Run the following commands:

```bash


docker-compose build
docker-compose up
docker-compose exec web bundle exec rails db:create
docker-compose exec web bundle exec rails db:migrate