class OrdersController < ApplicationController
	skip_before_action :verify_authenticity_token
  # require 'active_merchant'
  # require 'mailgun'
  require 'net/https'
  require 'open-uri'

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

  def recurring_charge
    
    scheduler = Rufus::Scheduler.new
    
    # scheduler.cron '1 0 * * *' do
    scheduler.cron '* * * * *' do
      now = Date.today
      jewish_date = Unirest.get("http://www.hebcal.com/converter/?cfg=json&gy=#{now.year}&gm=#{now.month}&gd=#{now.day}&g2h=1").body["hd"]
      # if jewish_date == 27
      p 'This is the Jewish Date: '
      p jewish_date
        recurring_donations = Order.where(recurring: true)
        recurring_donations.each do |donation|
          url = URI.parse('https://x1.cardknox.com/gateway')
          params = {
            xAmount: donation.total.to_f,
            xToken: donation.token,
            xKey: "DKDesignDev_Test_c9c4afc456b0446ba93814ae99a5",
            xCommand: "cc:sale",
            xVersion: "4.5.5",
            xSoftwareName: "Evergreen",
            xSoftwareVersion: "1.0"
          }
          x = Net::HTTP.post_form(url, params)
        end
        render "recurring_charge.html.erb"
      # end #end if
    end #end scheduler

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
