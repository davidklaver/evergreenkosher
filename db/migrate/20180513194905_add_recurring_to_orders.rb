class AddRecurringToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :recurring, :boolean
  end
end
