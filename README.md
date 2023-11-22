# CommuniChat README

CommuniChat is a chat system that allows the creation of applications containing multiple chats and messages.

## How to Set Up

Clone the repository:

```bash
git clone https://github.com/Yasmine-Arafa/CommuniChat

cd CommuniChat
```

build the project

```bash
docker-compose build

docker-compose up -d
```

Setup the database

```bash
docker-compose exec web bundle exec rails db:create

docker-compose exec web bundle exec rails db:migrate
```
