# README
rails generate # to see available things

# creating migration
rails generate model BlogPost title:string body:text

# applying migration
rails db:migrate

# where sql lives
\\wsl.localhost\Ubuntu-24.04\home\rprado_ubuntu\blog\storage

# playground terminal
`rails console` or `rails c` for short or even shorter `irb`

- **rails console** – This command starts a Rails-specific interactive console. It loads your Rails application, making all your models, libraries, and configurations available. It's the best choice for working within a Rails project.

- **rails c** – This is just a shorthand alias for rails console. So, they're functionally the same—rails c just saves you a few keystrokes.

- **irb (Interactive Ruby)** – This is a generic Ruby REPL (Read-Eval-Print Loop) that allows you to run Ruby code interactively. However, it does NOT load your Rails application automatically, meaning you'll need to manually require any Rails dependencies if you want to use them.

So, if you're working inside a Rails project, it's best to use `rails consol`e (or `rails c`). If you just need to test out Ruby code in isolation, irb is a fine choice.
```

# running
```
rails server
http://127.0.0.1:3000/
```


# Useful things
## Debug wise
`binding.irb` stops the code and allow for debugging inspection
`continue`
`abort`
`next`
`exit`

## Query wise
To see queries either do **.to_sql** when playing with the model itself or activate active record log verbosity to see queries your app in doing while executing a given workflow **ActiveRecord::Base.logger = Logger.new(STDOUT)**
```
blog(dev)> BlogPost.all
  BlogPost Load (2.5ms)  SELECT "blog_posts".* FROM "blog_posts" /* loading for pp */ LIMIT 11 /*application='Blog'*/
=> []
blog(dev)> BlogPost.all.to_sql
=> "SELECT \"blog_posts\".* FROM \"blog_posts\""
```


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
