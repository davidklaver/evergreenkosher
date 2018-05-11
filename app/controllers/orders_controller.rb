class OrdersController < ApplicationController
	skip_before_action :verify_authenticity_token
  # require 'active_merchant'
  # require 'mailgun'

  def new
    @carted_donation_items = []
    
    session[:cart].each do |carted_donation_item_id|
      @carted_donation_items << CartedDonationItem.find_by("status = ? and id = ?", "carted", carted_donation_item_id)
      p"**************"
      @description = []
      @carted_donation_items.each do |item|
        @description << item.quantity.to_s + " " + item.donation_item.name
      end
    end  
    # @description = ""
    # @carted_donation_items.each { |item|  }
  
    @subtotal = 0
    @carted_donation_items.each do |carted_donation_item|
      @total += carted_donation_item.price * carted_donation_item.quantity
    end
    @invoiceNumber = Order.last.id + 100
  end



  def create
    carted_donation_item_ids = eval(params[:xCustom02])
    @carted_donation_items = []
    carted_donation_item_ids.each do |carted_donation_item_id|
      @carted_donation_items << CartedDonationItem.find_by("status = ? and id = ?", "carted", carted_donation_item_id)
    end

    order1 = Order.create(total: params[:xAmount], ref_num: params[:xRefNum], email: params[:xEmail])

    @carted_donation_items.each do |carted_donation_item|
      carted_donation_item.update(status: "purchased", order_id: order1.id)
    end

    session[:cart] = []

    # Send email to the purchaser with order details using MailGun:
    RestClient.post "https://api:#{ENV['MAILGUN_API_KEY']}"\
  "@api.mailgun.net/v3/mail.chopandchillny.com/messages",
    :from => "noreply@chopandchillny.com",
    :to => order1.email,
    :bcc => "chopandchillny@gmail.com",
    :subject => "Congrats on your Chop and Chill Order!",
    :html => "Here's your order info: 
    <p>Total: $#{order1.total}</p>
    <p>Reference Number: #{order1.ref_num}</p>
    <p>For more order details, click <a href='www.chopandchillny.com/orders/#{order1.id}?xRefNum=#{order1.ref_num}'>here</a></p>
    "
    # flash[:success] = "Congrats! Your order has been placed!"
    # render "/orders/#{order1.id}?xRefNum=#{params[:xRefNum]}"

    
    # @html = "<html><body><script type='text/javascript' charset='utf-8'>window.parent.document.location.href = '/orders/#{order1.id}';</script></body></html>".html_safe
    # render inline: "<%= @html %>"
  end

  def show
    @order = Order.find(params["id"])    
    redirect_to "/donation_items" unless @order.ref_num == params[:xRefNum]
  end
end
