class Order < ApplicationRecord
	has_many :carted_donation_items
  has_many :donation_items, through: :carted_donation_items

end
