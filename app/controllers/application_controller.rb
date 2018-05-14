class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to '/login' unless current_user
  end

   def authenticate_admin!
    redirect_to '/donation_items' unless current_user && current_user.admin
  end

  def cart_count
    carted_donation_items = CartedDonationItem.where("status = ? and session_id = ?", "carted", session.id)
  	@cart_count = 0
    carted_donation_items.each do |item|
      @cart_count += item.quantity
    end
    @cart_count
  end
  helper_method :cart_count
end
