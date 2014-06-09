module FlashAlerts
	def notice
		flash[:notice] = "All changes saved."
	end
	
	def error
		flash[:error] = "You must be authenticated to do that."
	end
	
	def warning
		flash[:warning] = "Please enter the correct credentials."
	end
	
  def alert
		flash[:alert] = "Please enter valid data."
	end
end
