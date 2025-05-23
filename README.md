# README
original material from: original material from: https://gorails.com/series/build-a-blog-with-rails-7

# rails generate command
`rails generate` or `rails g` # to see available things

# creating migration
```
rails generate model BlogPost title:string body:text

rails generate migration AddPublishedAtToBlogPosts published_at:datetime
```

# populate db data
rails db:seed

# applying migration
`rails db:migrate`

# switching from default sqlit to something else
```
rails db:system:change --to=postgresql

# Supported preconfigurations are: mysql, trilogy, postgresql, sqlite3, mariadb-mysql, mariadb-trilogy.
```


remember to setup the database locally:
```
sudo apt install postgresql libpq-dev 
bundle install --gemfile /home/rprado_ubuntu/blog/Gemfile
sudo service postgresql start
sudo -u postgres createuser -s rprado_ubuntu    
```

# where sqlite lives
`wsl.localhost\Ubuntu-24.04\home\rprado_ubuntu\blog\storage`

# playground terminal
`rails console` or `rails c` for short or even shorter `irb`

- **rails console** – This command starts a Rails-specific interactive console. It loads your Rails application, making all your models, libraries, and configurations available. It's the best choice for working within a Rails project.

- **rails c** – This is just a shorthand alias for rails console. So, they're functionally the same—rails c just saves you a few keystrokes.

- **irb (Interactive Ruby)** – This is a generic Ruby REPL (Read-Eval-Print Loop) that allows you to run Ruby code interactively. However, it does NOT load your Rails application automatically, meaning you'll need to manually require any Rails dependencies if you want to use them.

So, if you're working inside a Rails project, it's best to use `rails consol`e (or `rails c`). If you just need to test out Ruby code in isolation, irb is a fine choice.


# running
http://127.0.0.1:3000/
```
rails server # server only
bin/dev # server + css
```


# Useful things

## Syntax
```
blog(dev)> 
blog(dev)> 1.year.ago
=> 2024-04-16 14:36:43.467939500 UTC +00:00
blog(dev)> 1.year.from_now
=> 2026-04-16 14:36:47.688396600 UTC +00:00`
```

## Dealing with Time and Date
In Rails, Time.now and Time.current are two different ways to get the current time. While they may seem similar, there's a subtle difference between them.

Time.now returns the current time in the system's timezone, which is usually the timezone of the server. This means that if your server is running in a different timezone than your application's timezone, Time.now will return the wrong time.

On the other hand, Time.current returns the current time in the application's timezone, which is set in the config/application.rb file or in the config/environments/*.rb files. This means that Time.current will always return the correct time, regardless of the server's timezone.

In general, it's recommended to use Time.current instead of Time.now in Rails applications, especially when working with dates and times that need to be displayed to users in their local timezone.


### Debug wise
- `binding.irb` stops the code and allow for debugging inspection
- `continue`
- `abort`
- `next`
- `exit`

## Query wise
To see queries either do **.to_sql** when playing with the model itself or activate active record log verbosity to see queries your app in doing while executing a given workflow **ActiveRecord::Base.logger = Logger.new(STDOUT)**
```
blog(dev)> BlogPost.all
  BlogPost Load (2.5ms)  SELECT "blog_posts".* FROM "blog_posts" /* loading for pp */ LIMIT 11 /*application='Blog'*/
=> []
blog(dev)> BlogPost.all.to_sql
=> "SELECT \"blog_posts\".* FROM \"blog_posts\""
```


## adding dependencies
```
bundle add DEPENDENCY_NAME
```
bundle add devise
rails g devise:install
rails g devise User

bundle add tailwindcss-rails
rails tailwindcss:install


`rails g devise:views` copy the login views to your app so you can customize things if you want to


## hosting options
- https://render.com/pricing
- https://fly.io/pricing/
- https://hatchbox.io/pricing
- https://www.heroku.com/pricing

create env var `RAILS_MASTER_KEY` with content of `cat config/master.key` (After you ran `bin/rails credentials:edit`)

## "eslint --fix"
rubocop -a


## action text (rich text editor)
bin/rails action_text:install

to get its content: `BlogPost.first.content.body`
p.s.: remember to install `gem "image_processing", "~> 1.2"`
as well as sudo apt-get install libvips-dev


## adding rails console to the browser so you can inpsect live
just do
```
<%= console %>
```

## for pagination in the ui / api
pagy - https://github.com/ddnexus/pagy

good to read: 
- https://ddnexus.github.io/pagy/docs/how-to/#handle-pagyoverflowerror-exceptions
- https://ddnexus.github.io/pagy/docs/how-to/#skip-single-page-navs

eg:
```
gem 'pagy', '~> 3.3'

class UsersController < ApplicationController
  def index
    @users = pagy(User.all, page: params[:page], items: 10)
    render json: @users
  end
end
```

## pagination with plain ActiveRecord
```
# app/controllers/concerns/paginatable.rb
module Paginatable
  extend ActiveSupport::Concern

  def paginate(scope, per_page = 10)
    page = params[:page] || 1
    per_page = params[:per_page] || per_page

    scope.limit(per_page).offset((page - 1) * per_page)
  end

  def pagination_metadata(scope, page, per_page)
    total_count = scope.count
    total_pages = (total_count.to_f / per_page).ceil

    {
      total_count: total_count,
      total_pages: total_pages,
      page: page,
      per_page: per_page
    }
  end
end
```
Then, in your controllers, you can include the **Paginatable** concern and use the **paginate** and **pagination_metadata** methods:
```
# app/controllers/users_controller.rb
class UsersController < ApplicationController
  include Paginatable

  def index
    @users = paginate(User.all)
    metadata = pagination_metadata(User.all, params[:page], params[:per_page])

    render json: {
      users: @users,
      pagination: metadata
    }
  end
end
```
# routes
```
rails routes
rails routes -g cover_image #filters it with a grep
```

# Default docs scaffolded by rails cli

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
