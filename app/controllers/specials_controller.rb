class SpecialsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :update, :destroy, :new, :edit]

	def index
		@monsey_specials = Special.last
	end

	def show
		
	end

	def new
		@special = Special.new
	end

	def create
		@special = Special.new(
				link: params[:link],
				produce_link: params[:produce_link],
				good_thru: params[:good_thru]
			)
		if @special.save
			flash[:success] = ("Specials added succesfully!")
			redirect_to "/specials"
		else
			render "new.html.erb"
		end
	end
end
