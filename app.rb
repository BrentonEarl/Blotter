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
  helpers SiteInformation

  #### 404 and 500
  not_found do
    information
    list_all_pages
    @title = "Not Found"
    erb :'404'
  end

  error do
    information
    list_all_pages
    @title = "Error"
    erb :'500'
  end

  #### Installation
  get '/install' do
    information
    list_all_pages
    @title = "Site Installation"
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
    list_all_pages
    @title = "Index"
    @post = Posts.order("created_at DESC").limit(6)
    erb :index
  end

  #### Contact Us
  get '/contact' do
    information
    list_all_pages
    @title = "Contact Us"
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
    redirect '/contact'
  end

  #### Archives page
  get '/archives' do
    information
    list_all_pages
    @title = "Site Archives"
    posts = Posts.all
    @post_months = posts.group_by { |m| m.created_at.beginning_of_month }
    erb :archives
  end

  #### Categories Page
  get '/category/:category' do  ### Add Route error handling
    begin
      information
      list_all_pages
      @category = Category.find_by(:name => params[:category])
      @categories = Category.where(:name => params[:category])
      @title = "Category: " + @category.name
      erb :categories
    rescue
      flash[:error] = "That category does not exist."
      redirect '/404'
    end
  end

  #### Login
  get '/login' do
    information
    list_all_pages
    @title = "Log In"
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
  get '/admin' do
    if signed_in?
      information
      @title = "Administration"
      list_all_pages
      @post = Posts.order("created_at DESC")
      erb :'admin/index'
    else
      redirect '/login'
    end
  end

  #### Dynamic Pages
  get '/pages/new' do
    if signed_in?
      information
      list_all_pages
      @title= "New Page"
      erb :'pages/new'
    else
      error
      redirect '/login'
    end
  end

  post '/pages/new' do
    if signed_in?
      page = Pages.new
      page.title = params[:title]
      page.body = params[:body]
      if page.save
        redirect '/admin'
      else
        alert
        redirect '/pages/new'
      end
    else
      error
      redirect '/login'
    end
  end

  get '/pages/:id/edit' do
    if signed_in?
      begin
        information
        list_all_pages
        find_page_by_id
        @title = @page.title
        erb :'pages/edit'
      rescue
        status 404
        redirect '/404'
      end
    else
      error
      redirect '/login'
    end
  end

  post '/pages/:id/edit' do
    if signed_in?
      begin
        find_page_by_id
        @page.title = params[:title]
        @page.body = params[:body]
        if @page.save
          notice
          redirect '/admin'
        else
          alert
          redirect '/admin'
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

  get '/pages/:id/delete' do
    if signed_in?
      begin
        information
        @title = "Delete Page"
        list_all_pages
        find_page_by_id
        erb :'pages/delete'
      rescue
        status 404
        redirect '/404'
      end
    else
      error
      redirect '/login'
    end
  end

  post '/pages/:id' do
    if signed_in?
      begin
        Pages.find(params[:id]).destroy
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

  get '/allpages' do
    information
    @title = "Site Pages"
    list_all_pages
    erb :'pages/allpages'
  end

  get '/pages/:id' do
    begin
      information
      find_page_by_id
      @title = @page.title
      list_all_pages
      erb :'pages/view'
    rescue
      status 404
      redirect '/404'
    end
  end

  #### Posts
  get '/posts/new' do
    if signed_in?
      information
      @title = "New Post"
      list_all_pages
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
        information
        @title = "Edit Post"
        list_all_pages
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
        @category.update(:name => params[:category])
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
        information
        @title = "Delete Post"
        find_post_by_id
        list_all_pages
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
    begin
      information
      find_post_by_id
      find_category_by_post_id
      @title = @post.title
      list_all_pages
      erb :'posts/view'
    rescue
      status 404
      redirect '/404'
    end
  end

end
