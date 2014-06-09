module CommonQueries
	def find_post_by_id
		@post = Posts.find(params[:id])
	end

	def find_page_by_id
		@page = Pages.find(params[:id])
	end
	
	def list_all_pages
		@links = Pages.order(:title)
	end
	
	def find_category_by_post_id
		@category = Category.joins(:posts).find_by(posts: { id: params[:id] })
	end		
end
