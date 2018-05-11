class DonationItem < ApplicationRecord
	has_many :carted_donation_items
	validates :name, presence: true
	validates :price, :numericality => {:greater_than => 0, :less_than => 1000}

	def tax
		price * 0.0875
	end

	def total
		price + tax
	end
end
