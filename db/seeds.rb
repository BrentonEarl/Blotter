require './db/models/init'

if Posts.count == 0
  print "Seed:  Create Posts."
  print "\n\n"

  3.times do
    post = Posts.new  # Current Post
    category = Category.new
  
    post.title = "First Update"
    post.author = "Brenton Earl"
    post.summary = "Welcome to the new site."
    post.body = "Welcome to the site.  Over the next few days there may be a some changes in the event that something does not work as expected.  For all intensive purposes though, the site is launched.  Please bookmark the site and keep coming back!"
    post.created_at = Time.now.strftime('%m-%d-%Y %I:%M%p')

    category.name = "Update 1"
    post.categories << category

    post.save
  end

  3.times do
    time2 = Time.now
    last_month =  time2 - 86400 * 30 
    
    post = Posts.new
    category = Category.new
  
    post.title = "Second Update"
    post.author = "Brenton Earl"
    post.summary = "Welcome to the new site."
    post.body = "Welcome to the site.  Over the next few days there may be a some changes in the event that something does not work as expected.  For all intensive purposes though, the site is launched.  Please bookmark the site and keep coming back!"
    post.created_at = last_month.strftime('%m-%d-%Y %I:%M%p')

    category.name = "Update 2"
    post.categories << category

    post.save
  end
  
  3.times do
    time3 = Time.now
    last_year = time3 - 86400 * 30 * 12
    
    
    post = Posts.new
    category = Category.new
  
    post.title = "Third Update"
    post.author = "Brenton Earl"
    post.summary = "Welcome to the new site."
    post.body = "Welcome to the site.  Over the next few days there may be a some changes in the event that something does not work as expected.  For all intensive purposes though, the site is launched.  Please bookmark the site and keep coming back!"
    post.created_at = last_year.strftime('%m-%d-%Y %I:%M%p')

    category.name = "Update 3"
    post.categories << category

    post.save
  end
  print " Created posts."
  print "\n\n"
else
  print " Posts not created."
  print "\n\n"
end

if SiteSettings.count == 0
  print "Seed:  Create default site settings"
  print "\n\n"

  SiteSettings.create(
  name: "Exit Status One",
  tagline: "Possesion of anything begins in the mind...",
  author: "Brenton Earl",
  meta_description: "A compilation on information about music, Linux, Ruby programming and interesting news.",
  meta_keywords: "Linux, Ruby, Sinatra, Rails, SQL, HTML, CSS, Music, Punk, Rock, Indie",
  about_site: "This site was developed by Brenton Earl.  It uses the Sinatra DSL, which is written in the Ruby programming language."
  )
  print " Created Default Site Settings"
  print "\n\n"
end
