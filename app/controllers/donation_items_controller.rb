class DonationItemsController < ApplicationController
  before_action :set_donation_item, only: [:show, :edit, :update, :destroy]
  require 'rufus-scheduler'
  # require 'date'

  def index
    @donation_items = DonationItem.all.sort_by { |item| item.id  }
  end

  def show
  end

  def new
    @donation_item = DonationItem.new
  end

  def edit
  end

  def create
    @donation_item = DonationItem.new(donation_item_params)

    respond_to do |format|
      if @donation_item.save
        format.html { redirect_to @donation_item, notice: 'Donation item was successfully created.' }
        format.json { render :show, status: :created, location: @donation_item }
      else
        format.html { render :new }
        format.json { render json: @donation_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @donation_item.update(donation_item_params)
        format.html { redirect_to @donation_item, notice: 'Donation item was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation_item }
      else
        format.html { render :edit }
        format.json { render json: @donation_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @donation_item.destroy
    respond_to do |format|
      format.html { redirect_to donation_items_url, notice: 'Donation item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_item
      @donation_item = DonationItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_item_params
      params.require(:donation_item).permit(:name, :price, :price, :image_url)
    end
end
