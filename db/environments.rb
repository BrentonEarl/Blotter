configure :development do
  set :database, 'sqlite3:./db/dev.sqlite3'
  set :show_exceptions, true
end

configure :test do
  set :database, 'sqlite://./db/sqlite3.test'
  set :show_exceptions, true
end

configure :production do
  ActiveRecord::Base.establish_connection(
    :adapter  => 'postgresql',
    :host     => '127.0.0.1',
    :username => 'facerip',
    :password => 'password',
    :database => 'blotter_production',
    :encoding => 'utf8'
    )
end
