module SiteAuthentication
	def authenticate
		user = User.find_by(email: params[:email].downcase)
		if user && user.authenticate(params[:password])
			sign_in user
			flash[:notice] = "Welcome, #{user.name}!"
			redirect '/admin'
		else
			warning
			redirect '/login'
		end
	end

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end
    
	def current_user=(user)
		@current_user = user
	end
    
	def current_user
		remember_token = User.digest(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
		cookies[:remember_token] = nil
		self.current_user = nil
	end
end
