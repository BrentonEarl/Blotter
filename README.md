Blotter
=======

Blotter is a blogging software written in Ruby.  It was created to replace Wordpress for the site [http://exitstatusone.com](http://exitstatusone.com).  It utilizes the [Sinatra DSL](http://www.sinatrarb.com/) and Active Record to store data in its database.

### Installation

*  Ruby 1.9.3 or greater

__Required Gems__

*  sinatra 1.4.5
*  sinatra-contrib 1.4.2
*  activerecord 4.1.1
*  mysql 2.9.1
*  rack-flash3 1.0.5
*  bcrypt-ruby 3.1.5
*  pony 1.8

__Deployment__

*  Install required Gems
*  Modify /config/database.yml and /db/environments.rb to reflect your database settings
*  Execute rake db:create and rake db:migrate in the root directory
*  Choose your web server, [Sinatra Recipes - Deployment](http://recipes.sinatrarb.com/p/deployment?#article).  Deployment has been tested using [Apache and Passenger](http://recipes.sinatrarb.com/p/deployment/apache_with_passenger?#article)
*  Once the site is running, visit yourdomain.com/install 
*  Create the administrative account at /install, anyone will be able to create a user, so do this quickly
*  Site settings can be found at /admin/settings, update to reflect your blog's information

### Troubleshooting

*  The contact page is currently left unconfigured in the Sinatra route.  You must add your email settings to have a functional email form.

### Future Features

(In no peticular order)

*  Archives and Search
*  Media Gallery and uploads
*  Comments and comment moderation
*  Theme Customization Settings
*  Database Export for backup
