class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:create, :update, :destroy, :new, :edit]
	def index
		@posts = Post.all
	end

	def show
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
	  @post = Post.new(post_params)

      if @post.save
         redirect_to '/posts'
      else
        render :new
      end
	end

private

	def post_params
	  params.require(:post).permit(:title, :image, :youtube_id)
	end

	def set_post
      @post = Post.find(params[:id])
    end
end
