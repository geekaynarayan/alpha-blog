class SessionsController < ApplicationController
	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user 
			user.authenticate(params[:session][:password])
			session[:user_id] = user.id #this user_id is stored in the session using cookies
			flash[:success] = "Login Successful!"
			redirect_to user_path(user)
		else
			flash.now[:danger] = "Invalid credentials."
			render 'new'
		end
	end

	def destroy #logout the user
		session[:user_id] = nil
		flash[:success] = "You have logged out."
		redirect_to root_path
	end

end
