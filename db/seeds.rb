require './db/models/init'


print "Seed #1:  Create 5 test posts\n\n"
5.times do |i|
    Posts.create(
      title: "Hello World ##{i}",
      author: "Brenton Earl",
      summary: "This is post number ##{i}.",
      body: "Welcome to the site.  This is post number ##{i}.  
             Please stick around for further updates."
    )
    print "Created ##{i} posts\n"
end

print "\n Seed #2:  Create default site settings\n\n"

#### Add some test data to site settings table
1.times do |i|
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
  print "Created Default Site Settings\n"
end