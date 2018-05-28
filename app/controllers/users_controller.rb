class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	before_action :require_admin, only: [:destroy]

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

	def destroy
		# abort @user.inspect #use this to debug hard to debug scenarios
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = "User and articles owned by this user has been deleted."
		redirect_to users_path
	end

	private def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	private def set_user
		@user = User.find(params[:id])
		#abort @user.inspect
	end

	private def require_same_user
		if current_user != @user && !current_user.admin?
			flash[:danger] = "You can only edit your own account."
			redirect_to root_path
		end
	end

	private def require_admin
		if logged_in? && !current_user.admin?
			flash[:danger] = "Admin role required to delete users."
			redirect_to root_path
		end
	end

end
