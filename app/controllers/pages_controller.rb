class PagesController < ApplicationController
	def index
		@posts = Post.all
	end

	def specials
		
	end
end
