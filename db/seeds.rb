require './db/models/init'

print "\n\n"
print "Seed:  Created 1 Test Post."
print "\n"
if Posts.count == 0
  20.times do
  post = Posts.new
  category = Category.new
  
  post.title = "First Update"
  post.author = "Brenton Earl"
  post.summary = "Welcome to the new site."
  post.body = "Welcome to the site.  Over the next few days there may be a some changes in the event that something does not work as expected.  For all intensive purposes though, the site is launched.  Please bookmark the site and keep coming back!"
  # Add category
  category.name = "Update"
  post.categories << category

  post.save
  end
    print " Created posts."
else
  print " Post not created.  It already exists"
end

print "\n\n"
print "Seed:  Create default site settings"
print "\n"

#### Add some test data to site settings table
if SiteSettings.count == 0
  SiteSettings.create(
  name: "Exit Status One",
  tagline: "Possesion of anything begins in the mind...",
  author: "Brenton Earl",
  meta_description: "A compilation on information about music, Linux, Ruby programming and interesting news.",
  meta_keywords: "Linux, Ruby, Sinatra, Rails, SQL, HTML, CSS, Music, Punk, Rock, Indie",
  about_site: "This site was developed by Brenton Earl.  It uses the Sinatra DSL, which is written in the Ruby programming language."
  )
  print " Created Default Site Settings"
end

print "\n\n"
print "\n"
