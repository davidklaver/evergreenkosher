class PagesController < ApplicationController
	def index
		# @posts = Post.all
		@last_three_posts = Post.last(3).reverse
	end

	def specials
		
	end
end
