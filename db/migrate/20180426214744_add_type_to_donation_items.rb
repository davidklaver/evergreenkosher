class AddTypeToDonationItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :donation_items, :type, :string
  end
end
