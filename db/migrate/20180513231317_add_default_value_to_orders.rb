class AddDefaultValueToOrders < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :orders, :recurring, false
  end
end
