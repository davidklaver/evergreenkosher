class CartedDonationItemsController < ApplicationController
	def index
    carted_donation_items = CartedDonationItem.where("status = ? and session_id = ?", "carted", session.id)
    session[:cart] = []
    carted_donation_items.each do |carted_donation_item|
    	session[:cart] << carted_donation_item.id
		end
		if session[:cart].empty?
			flash[:warning] = "Your Cart is empty! Click below to begin ordering."
			redirect_to "/donation_items"
		end
		@carted_donation_items = []
		session[:cart].each do |carted_donation_item_id|
			@carted_donation_items << CartedDonationItem.find_by("status = ? and id = ?", "carted", carted_donation_item_id)
		end
		
		@total = 0
		
		@carted_donation_items.each do |carted_donation_item|
			@total += carted_donation_item.price * carted_donation_item.quantity
		end
		
	end

	def create

		if params[:quantity] == nil
			quantity = 1
		else
			quantity = params["quantity"]
		end

		donation_item = DonationItem.find(params["donation_item_id"])

		@carted_donation_item = CartedDonationItem.new(
				status: "carted",
				session_id: session.id,
				donation_item_id: params["donation_item_id"],
				quantity: quantity,
				price: donation_item.price
			)
		if @carted_donation_item.save
		  link = ("<a href=#{url_for(action:'index',controller:'carted_donation_items')}>your cart</a>")
			flash[:info] = ("You have added #{@carted_donation_item.donation_item.name} to #{link}.")
			redirect_to "/donation_items"
		else
			@donation_item = donation_item.find(params["donation_item_id"])
			render "/donation_items/show.html.erb"
		end
	end

	def destroy
		carted_donation_item = CartedDonationItem.find(params["id"])
		carted_donation_item.update(status: "removed")
		flash[:warning] = "You have removed #{carted_donation_item.donation_item.name} from your cart."
		redirect_to "/carted_donation_items"
	end
end
