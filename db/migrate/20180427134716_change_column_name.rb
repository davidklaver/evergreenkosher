class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :donation_items, :type, :description
  end
end
