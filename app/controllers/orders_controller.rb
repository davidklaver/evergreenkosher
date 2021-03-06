class OrdersController < ApplicationController
	skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:index]
  # require 'active_merchant'
  # require 'mailgun'
  require 'net/https'
  require 'open-uri'

  def index
    @donations = Order.all
  end

  def new
    @carted_donation_items = []
    @description = []
    @total = 0
    session[:cart].each do |carted_donation_item_id|
      @carted_donation_items << CartedDonationItem.find_by("status = ? and id = ?", "carted", carted_donation_item_id)
    end
    @carted_donation_items.each do |item|
      @description << item.quantity.to_s + " " + item.donation_item.name
      @total += item.price * item.quantity
    end  
    @invoiceNumber = Order.last.id + 238
  end

  def create

    session[:cart] = []
    carted_donation_item_ids = eval(params[:xCustom02])
    p "*" * 50 
    p "Here is carted_donation_item_ids:"
    p carted_donation_item_ids
    p "*" * 50
    @carted_donation_items = []
    carted_donation_item_ids.each do |carted_donation_item_id|
      @carted_donation_items << CartedDonationItem.find_by("status = ? and id = ?", "carted", carted_donation_item_id)
    end

    if params[:xCustom03] == "true"
      is_recurring = true
    else
      is_recurring = false
    end

    order1 = Order.create(total: params[:xAmount], ref_num: params[:xRefNum], email: params[:xEmail], token: params[:xToken], recurring: is_recurring)
    p "*" * 50 
    p order1
    p "*" * 50
    @carted_donation_items.each do |carted_donation_item|
      carted_donation_item.update(status: "purchased", order_id: order1.id)
    end

    # Send email to the purchaser with order details using MailGun:
  #   RestClient.post "https://api:#{ENV['MAILGUN_API_KEY']}"\
  # "@api.mailgun.net/v3/mail.chopandchillny.com/messages",
  #   :from => "noreply@chopandchillny.com",
  #   :to => order1.email,
  #   :bcc => "chopandchillny@gmail.com",
  #   :subject => "Congrats on your Chop and Chill Order!",
  #   :html => "Here's your order info: 
  #   <p>Total: $#{order1.total}</p>
  #   <p>Reference Number: #{order1.ref_num}</p>
  #   <p>For more order details, click <a href='www.chopandchillny.com/orders/#{order1.id}?xRefNum=#{order1.ref_num}'>here</a></p>
  #   "
    # flash[:success] = "Congrats! Your order has been placed!"
    # render "/orders/#{order1.id}?xRefNum=#{params[:xRefNum]}"

    
    # @html = "<html><body><script type='text/javascript' charset='utf-8'>window.parent.document.location.href = '/orders/#{order1.id}';</script></body></html>".html_safe
    # render inline: "<%= @html %>"
  end

  def show
    @order = Order.find(params["id"])    
    redirect_to "/donation_items" unless @order.ref_num == params[:xRefNum]
  end

  def recurring_charges
    
    scheduler = Rufus::Scheduler.new
    
    scheduler.cron '0 0 * * *' do
      now = Date.today
      jewish_date = Unirest.get("http://www.hebcal.com/converter/?cfg=json&gy=#{now.year}&gm=#{now.month}&gd=#{now.day}&g2h=1").body["hd"]
      p "*" * 50
      p 'This is the Jewish Date: '
      p jewish_date
      p "*" * 50
      if jewish_date == 1
      
        recurring_donations = Order.where(recurring: true)
        recurring_donations.each do |donation|
          url = URI.parse('https://x1.cardknox.com/gateway')
          params = {
            xAmount: donation.total.to_f,
            xToken: donation.token,
            xKey: ENV['CARDKNOX_API_KEY'],
            xCommand: "cc:sale",
            xVersion: "4.5.5",
            xSoftwareName: "Evergreen",
            xSoftwareVersion: "1.0"
          }
          p "*" * 50
          p "Here's some params: "
          p params
          p "*" * 50
          x = Net::HTTP.post_form(url, params)
          p "here's x:"
          p x
        end
       
      end #end if
    end #end scheduler
    render "recurring_charges.html.erb"
  end

  def cancel_recurring_charge_form
    
  end

  def cancel_recurring_charge
    if params[:email] != params[:email_confirmation]
      flash[:danger] = "Email confirmation must match"
      redirect_to '/orders/cancel_recurring_charge_form'
    end

    donation = Order.where("email = ? AND recurring = ?", params[:email], true)
    if donation != []
     donation.update(recurring: false)
   else
      flash[:danger] = "No recurring donation was found with that email address. Please try again."
      redirect_to '/orders/cancel_recurring_charge_form'
    end
  end

end
