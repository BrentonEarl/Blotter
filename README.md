Blotter
=======

Blotter is a blogging software written in Ruby.  It was created to replace Wordpress for the site [http://exitstatusone.com](http://exitstatusone.com).  It utilizes the [Sinatra DSL](http://www.sinatrarb.com/) and Active Record to store data in its database.

### Installation

*  Ruby 2.2.0r

__Required Gems__

*  sinatra
*  sinatra-contrib
*  activerecord
*  pg (postgresql
*  rack-flash3
*  bcrypt-ruby
*  pony

__Deployment__

*  Run Bundler:  bundle install
*  Modify /config/database.yml and /db/environments.rb to reflect your database settings
*  Execute rake db:create and rake db:migrate in the root directory
*  Choose your web server, [Sinatra Recipes - Deployment](http://recipes.sinatrarb.com/p/deployment?#article).  Deployment has been tested using [Apache and Passenger](http://recipes.sinatrarb.com/p/deployment/apache_with_passenger?#article)
*  Once the site is running, visit yourdomain.com/install 
*  Create the administrative account at /install, anyone will be able to create a user, so do this immediately
*  Site settings can be found at /admin/settings, update to reflect your blog's information

### Troubleshooting

*  The contact page is currently left unconfigured in the Sinatra route.  You must add your email settings to have a functional email form.

### Future Features

*  Media Gallery and uploads
*  Comments and comment moderation
*  Theme Customization Settings
*  Database Export for backup
*  Error handling for 404 and 500 statuses
