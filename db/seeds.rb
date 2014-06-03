require './db/models/init'

print "\n\n"
print "Seed:  Created 1 Test Post."
print "\n"
if Posts.count == 0
    post = Posts.new
    category = Category.new
    
    post.title = "Testing"
    post.author = "Brenton Earl"
    post.summary = "This is a test post."
    post.body = "Welcome to the site.  This is a test post."
    # Add category
    category.name = "Test"
    post.categories << category
    
    post.save
    print " Created post."
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
  tagline: "This is the tagline.",
  author: "Brenton Earl",
  meta_description: "The one stop shop for all things Linux and Ruby.",
  meta_keywords: "Linux, Ruby, Sinatra, Rails, SQL, HTML, CSS",
  about_site: "This site was developed by Brenton Earl.  
              It uses the Sinatra DSL, which is written in the 
              Ruby programming language."
  )
  print " Created Default Site Settings"
end

print "\n\n"
print "\n"
