module Installation  
	def create_user
		@user = User.new
		@user.name = params[:name]
		@user.email = params[:email]
		@user.password = params[:password]
		@user.password_confirmation = params[:password_confirmation]
		if @user.save
			notice
			authenticate
		else
			alert
			redirect '/install'
		end
	end
end  
