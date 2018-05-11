class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :ref_num
      t.string :email
      t.decimal :total, precision: 7, scale: 2

      t.timestamps
    end
  end
end
