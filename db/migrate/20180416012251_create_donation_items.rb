class CreateDonationItems < ActiveRecord::Migration[5.0]
  def change
    create_table :donation_items do |t|
      t.string :name
      t.decimal :price, :precision => 7, :scale => 2
      t.string :image_url

      t.timestamps
    end
  end
end
