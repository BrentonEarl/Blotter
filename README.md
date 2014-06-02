Blotter
=======

A blogging software written in Ruby.  It utilizes the [Sinatra DSL](http://www.sinatrarb.com/) to serve content, and Active Record to store data in its database.

#### Installation

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
*  From the root directory, execute rake db:create, rake db:migrate
*  Choose your deployment option.  Blotter runs using any rack based application deployment option.  Here are some options: [Sinatra Recipes - Deployment](http://recipes.sinatrarb.com/p/deployment?#article)
*  Deployment tested using [Apache and Passenger](http://recipes.sinatrarb.com/p/deployment/apache_with_passenger?#article)

##### IMPORTANT Deployment Steps

*  After you have the site running, visit yourdomain.com/install where yourdomain.com is your hosted domain name 
*  Create your first user at /install, anyone will be able to create a user, so do this quickly
*  Site settings can be found at /admin/settings, update to reflect your blog's information
*  You will have to configure the /contact page by editing the correct route and adding in your email settings

#### Future Features

1.  Theme Customization Settings
2.  Comments
3.  Comment Moderation Settings
3.  Categories
4.  Categories Settings
5.  Archives Page
6.  Media Gallery
7.  Media Uploads
8.  Contact Information Settings
9.  Email Server settings
10.  Database Exports / Backup

*  Note:  This app is a work in progress and is meant to be an eventual Wordpress replacement software for [Exit Status One](http://exitstatusone.com).
