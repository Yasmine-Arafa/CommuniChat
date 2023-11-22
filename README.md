# README

CommuniChat is a chat system, used to create new application which contains multiple chats and messages

How to setup:

```bash
git clone https://github.com/Yasmine-Arafa/CommuniChat

cd CommuniChat

docker-compose build

docker-compose up -d
```

Setup the database

```bash
docker-compose exec web bundle exec rails db:create

docker-compose exec web bundle exec rails db:migrate
```
