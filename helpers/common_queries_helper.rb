module CommonQueries
	def information
		# Is there a more efficient method to query
		# To lower the load on the database?
		SiteSettings.first()
	end 
	
	def find_post_by_id
		@post = Posts.find(params[:id])
	end
	
	def find_category_by_post_id
		@category = Category.joins(:posts).find_by(posts: { id: params[:id] })
	end	
end
