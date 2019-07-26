# railsgirls-app
Rails Girls App Tutorial
https://guides.railsgirls.com/app

# 動作環境
- Ruby 2.6.3
- Ruby on Rails 5.2.3
- sqlite3 1.4.1

# Docker環境セットアップ
```
$ docker-compose build
$ docker-compose run --rm railsgirls bundle exec rails db:create
$ docker-compose run --rm railsgirls bundle exec rails db:migrate
$ docker-compose up
```
