configure :development do
  set :database, 'sqlite3:./db/sqlite3.dev'
  set :show_exceptions, true
end

configure :test do
  set :database, 'sqlite://./db/sqlite3.test'
  set :show_exceptions, true
end

configure :production do
  ActiveRecord::Base.establish_connection(
    :adapter  => 'mysql',
    :host     => '127.0.0.1',
    :username => 'root',
    :password => 'toor',
    :database => 'blotter',
    :encoding => 'utf8'
    )
end