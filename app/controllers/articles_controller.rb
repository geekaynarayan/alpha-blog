class ArticlesController < ApplicationController

	# instead of coding redundantly you can create a method and have them execute at certain situations.
	before_action :set_article, only: [:edit, :update,:show, :destroy]

	def index
		@articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def show
		#@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def create
		# render plain: params[:article].inspect

		@article = Article.new(article_params)
		
		####### temporarily create a userid.
		@article.user = User.first

		if(@article.save)
			flash[:success] = "Article was successfully created."
			redirect_to article_path(@article)
		else
			render 'new'
		end
	end

	def edit
		#@article = Article.find(params[:id])
	end

	def update
		#@article = Article.find(params[:id])
		if(@article.update(article_params))
			flash[:success] = "Article was successfully updated."
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		#@article = Article.find(params[:id])
		@article.destroy
		flash[:danger] = "Article was successfully deleted."
		redirect_to articles_path
	end


	private def article_params
		params.require(:article).permit(:title, :description)
	end

	private def set_article
		@article = Article.find(params[:id])
	end

end
