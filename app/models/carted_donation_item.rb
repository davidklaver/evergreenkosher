class CartedDonationItem < ApplicationRecord
	belongs_to :order, optional: true
	belongs_to :user, optional: true
	belongs_to :donation_item
end
