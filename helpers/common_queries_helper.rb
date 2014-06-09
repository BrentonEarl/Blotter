module CommonQueries
	def information
		SiteSettings.first()
	end 
	
	def find_post_by_id
		@post = Posts.find(params[:id])
	end
	
	def find_category_by_post_id
		@category = Category.joins(:posts).find_by(posts: { id: params[:id] })
	end	
end
