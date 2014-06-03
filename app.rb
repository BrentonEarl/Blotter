#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/activerecord'
require "sinatra/cookies"
require 'rack-flash'
require 'pony'
require './db/environments'
require './db/models/init'

class Application < Sinatra::Base
  use Rack::Flash, :sweep => true 
  helpers Sinatra::Cookies
  enable :sessions

  #### BEGIN HELPERS
  helpers do
    #### Site Information
    def information
      SiteSettings.first()
    end 
    ####
    #### Flash alerts  
    def alert_notice
      flash[:notice] = "All changes saved."
    end
    def alert_error
      flash[:error] = "You must be authenticated to do that."
    end
    def alert_warning
      flash[:warning] = "Please enter the correct credentials."
    end
    def alert_alert
      flash[:alert] = "Please enter valid data."
    end
    ####
    #### Authentication
    def authenticate
      user = User.find_by(email: params[:email].downcase)
      if user && user.authenticate(params[:password])
      # Sign the user in, create session, and redirect to the users page
        sign_in user
        flash[:notice] = "Welcome, #{user.name}!"
        redirect '/admin'
      else
        alert_warning
        redirect '/login'
      end
    end
    ####
    #### User Sign In and Sign Out
    def sign_in(user)
      remember_token = User.new_remember_token
      cookies[:remember_token] = remember_token
      user.update_attribute(:remember_token, User.digest(remember_token))
      self.current_user = user
    end

    def signed_in?
      !current_user.nil?
    end
    
    def current_user=(user)
      @current_user = user
    end
    
    def current_user
      remember_token = User.digest(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token)
    end

    def sign_out
      current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
      cookies[:remember_token] = nil
      self.current_user = nil
    end     
    ####
    #### Install first user
    #### Install site settings
    def create_user
      @user = User.new
      @user.name = params[:name]
      @user.email = params[:email]
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      if @user.save
        alert_notice
        authenticate
      else
        alert_alert
        redirect '/install'
      end
    end
    ####
  end
  #### END HELPERS
  #### Installation 
  get '/install' do
    user = User.first()
    if user == nil
      erb :'install/new'
    else
      redirect '/'
    end
  end
  
  post '/install' do
    user = User.first()
    if user == nil
      create_user
    else
      redirect '/'
    end
  end
  ####
  #### Root
  get '/' do
    information
    @post = Posts.order("created_at DESC")
    erb :index
  end
  ####
  #### Contact Us
  get '/contact' do
    information
    erb :contact
  end

  post '/contact' do
    Pony.mail({
      :from => params[:name] + "<" + params[:email] + ">",
      :to => '',
      :subject => params[:name] + " has contacted you",
      :body => params[:message],
      :via => :smtp,
      :via_options => { 
        :address => 'smtp.gmail.com', 
        :port => '587', 
        :enable_starttls_auto => true, 
        :user_name => '', 
        :password => '', 
        :authentication => :plain, 
        :domain => ''
        }
      })
    flash[:notice] = "Your email has been sent.  You will be contacted shortly."
    redirect '/' 
  end
  ####
  #### About Us
  get '/about' do
    information
    erb :'about/view'
  end
 
   get '/about/edit' do
    if signed_in?
      information
      erb :'about/edit'
    else
      alert_error
      redirect '/login'
    end 
  end 
  
    post '/about/edit' do  ### About Page is not updating
    if signed_in?
      information
      information.about_site = params[:about_site]
      if information.save
        alert_notice
        redirect '/about'
      else
        alert_alert
        redirect '/about'
      end
    else
      alert_error
      redirect '/login'
    end
  end
  ####  
  #### Login
  get '/login' do
    erb :'sessions/login'
  end

  post '/session/create' do # Create Session
    authenticate
  end
  ####
  #### Destroy Login Session
  get '/logout' do
    sign_out
    flash[:notice] = "You are signed out."
    redirect '/'
  end
  ####
  #### Admin Panel
  get '/admin/settings' do
    if signed_in?
      erb :'admin/settings'
    else
      alert_error
      redirect '/login'
    end
  end

  post '/admin/settings/save' do
    if signed_in?
      data = SiteSettings.find_by(id: "1")
      data.name = params[:name]
      data.tagline = params[:tagline]
      data.author = params[:author]
      data.meta_description = params[:description]
      data.meta_keywords = params[:keywords]
      if data.save
        alert_notice
        redirect '/admin' 
      else
        alert_error
        redirect '/login'
      end
    else
      alert_error
      redirect '/login'
    end
  end

  get '/admin' do
    if signed_in?
      @post = Posts.order("created_at DESC")
      erb :'admin/index'
    else
      redirect '/login'
    end
  end
  ####
  #### Posts
  get '/posts/new' do
    if signed_in?
    erb :'posts/new'
    else
      alert_error
      redirect '/login'
    end
  end

  post '/posts/new' do
    if signed_in?
      post = Posts.new
      category = Category.new
      post.title = params[:title]
      post.author =  params[:author]
      post.summary = params[:summary]
      post.body = params[:body]
      category.name = params[:category]
      post.categories << category
      if post.save
        redirect '/admin'
      else
        alert_alert
        redirect '/posts/new'
      end
    else
      alert_error
      redirect '/login'
    end
  end

  get '/posts/:id/edit' do
    if signed_in?
      @post = Posts.find(params[:id])
      @category = Category.joins(:posts).find_by(posts: { id: params[:id] })
      erb :'posts/edit'
    else
      alert_error
      redirect '/login'
    end 
  end

  post '/posts/:id/edit' do
    if signed_in?
      post = Posts.find(params[:id])
      category = Category.joins(:posts).find_by(posts: { id: params[:id] })
      post.title = params[:title]
      post.author = params[:author]
      post.summary = params[:summary]
      post.body = params[:body]
      category.update(name: params[:category])
      if post.save
        redirect '/admin'
      else
        alert_alert
        redirect '/posts/new'
      end
    else
      alert_error
      redirect '/login'
    end
  end

  get '/posts/:id/delete' do
    if signed_in?
      @post = Posts.find(params[:id])
      erb :'posts/delete'
    else
      alert_error
      redirect '/login'
    end
  end

  post '/posts/:id' do
    if signed_in?
      Posts.find(params[:id]).destroy
      redirect '/admin'
    else
      alert_error
      redirect '/login'
    end
  end
    
  get '/posts/:id' do
    information
    @post = Posts.find(params[:id])
    @category = Category.joins(:posts).find_by(posts: { id: params[:id] })
    erb :'posts/view'
  end
  ####
end