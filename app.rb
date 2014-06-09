#!/usr/bin/env ruby

require "sinatra"
require "sinatra/activerecord"
require "sinatra/cookies"
require "rack-flash"
require "rack/protection"
require "pony"


require_relative "db/environments"
require_relative "db/models/init"
require_relative "helpers/helpers.rb"

class Application < Sinatra::Base

  use Rack::Protection
  use Rack::Flash, :sweep => true 

  helpers Sinatra::Cookies
  enable :sessions
  helpers SiteAuthentication
  helpers FlashAlerts
  helpers Installation
  helpers CommonQueries


  #### 404 and 500
  not_found do
    erb :'404'
  end
  error do
    erb :'500'
  end


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


  #### Root
  get '/' do
    information
    @post = Posts.order("created_at DESC").limit(6)
    erb :index
  end


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
        :domain => 'localhost.localdomain'
        }
      })
    flash[:notice] = "Your email has been sent.  You will be contacted shortly."
    redirect '/' 
  end


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
      error
      redirect '/login'
    end 
  end 
  
	post '/about/edit' do
		if signed_in?
      information
      information.about_site = params[:about_site]
      if information.save
        notice
        redirect '/about'
      else
        alert
        redirect '/about'
      end
    else
      error
      redirect '/login'
    end
  end


  #### Archives page
  get '/archives' do
    posts = Posts.all
    @post_months = posts.group_by { |m| m.created_at.beginning_of_month }
    erb :archives
  end


  #### Categories Page
  get '/category/:category' do  ### Add Route error handling
    begin
      @category = Category.find_by(name: params[:category])
      @categories = Category.where(name: params[:category])
      erb :categories
    rescue
      flash[:error] = "That category does not exist."
      redirect '/404'
    end
  end 


  #### Login
  get '/login' do
    erb :'sessions/login'
  end

  post '/session/create' do # Create Session
    authenticate
  end

  #### Destroy Login Session
  get '/logout' do
    sign_out
    flash[:notice] = "You are signed out."
    redirect '/'
  end


  #### Admin Panel
  get '/admin/settings' do
    if signed_in?
      erb :'admin/settings'
    else
      error
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
        notice
        redirect '/admin' 
      else
        error
        redirect '/login'
      end
    else
      error
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


  #### Posts
  get '/posts/new' do
    if signed_in?
    erb :'posts/new'
    else
      error
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
      post.created_at = Time.now.strftime('%m-%d-%Y %I:%M%p')
      category.name = params[:category]
      post.categories << category
      if post.save
        redirect '/admin'
      else
        alert
        redirect '/posts/new'
      end
    else
      error
      redirect '/login'
    end
  end

  get '/posts/:id/edit' do ## Consider better route error handling
    if signed_in?
    	begin
	      find_post_by_id
  	    find_category_by_post_id
  	    erb :'posts/edit'
  	  rescue
  	  	status 404
  	  	redirect '/404'
  	  end
    else
      error
      redirect '/login'
    end 
  end

  post '/posts/:id/edit' do  ## Consider better route error handling
    if signed_in?
    	begin
	      find_post_by_id
  	    find_category_by_post_id
  	    @post.title = params[:title]
  	    @post.author = params[:author]
  	    @post.summary = params[:summary]
  	    @post.body = params[:body]
  	    @category.update(name: params[:category])
  	    if @post.save
  	    	notice
  	      redirect '/admin'
  	    else
  	      alert
  	      redirect '/posts/new'
  	    end
			rescue
				status 404
				redirect '/404'
			end
    else
      error
      redirect '/login'
    end
  end

  get '/posts/:id/delete' do
    if signed_in?
      begin
        find_post_by_id
        erb :'posts/delete'
			rescue
        status 404
        redirect '/404'
      end
    else
      error
      redirect '/login'
    end
  end

  post '/posts/:id' do
    if signed_in?
    	begin
        Posts.find(params[:id]).destroy
        redirect '/admin'
			rescue
        status 404
        redirect '/404'
      end
    else
      error
      redirect '/login'
    end
  end

  get '/posts/' do
    redirect '/archives'
  end
  
  get '/posts/:id' do
    information
		begin
      find_post_by_id 
      find_category_by_post_id 
      erb :'posts/view'
		rescue
      status 404
      redirect '/404'
    end
  end


end
