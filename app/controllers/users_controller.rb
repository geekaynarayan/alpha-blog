class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update, :show]

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if (@user.save)
			session[:user_id] = @user.id
			flash[:success] = "Sign up Successful!! Welcome to the alpha blog #{@user.username}."
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def edit
		#@user = User.find(params[:id]) #fulfilled by before_action (see above)
	end

	def update
		#@user = User.find(params[:id])

		if(@user.update(user_params))
			flash[:success] = "Update Successful!"
			redirect_to articles_path
		else
			render 'edit'
		end
	end

	def show
		#@user = User.find(params[:id])
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end


	private def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	private def set_user
		@user = User.find(params[:id])
	end

end
