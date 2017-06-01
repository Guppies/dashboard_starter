Dashboard Starter
================

This application requires:

- Ruby 2.3.3
- Ruby on Rails 5.0.2
- redis-server
- PostgreSQL
- rbenv (optional)
- tmux (optional to start the app by using the bash script)

Getting Started:
---------------

`bundle install`

- Update your credentials in database.yml

`rake db:create`

`rake db:migrate`

`rake db:seed`

- An admin user is created when running `rake db:seed`, you can find the username and password inside `config/secrets.yml`

- The application sends the emails asynchronous so sidekiq and redis must be started
- To use the bash script please update the appropriate paths inside the file
- You can update the mailgun credentials to non sandbox account inside secrets.yml so you can send emails to non authorized users
