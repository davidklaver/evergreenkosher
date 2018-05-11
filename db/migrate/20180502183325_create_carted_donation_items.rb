class CreateCartedDonationItems < ActiveRecord::Migration[5.0]
  def change
    create_table :carted_donation_items do |t|
      t.string :status
      t.integer :quantity
      t.integer :order_id
      t.integer :donation_item_id
      t.string :session_id
      t.decimal :price, precision: 7, scale: 2

      t.timestamps
    end
  end
end
