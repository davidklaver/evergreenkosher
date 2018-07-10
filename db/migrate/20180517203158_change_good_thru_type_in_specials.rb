class ChangeGoodThruTypeInSpecials < ActiveRecord::Migration[5.0]
  def change
  	change_column :specials, :good_thru, :string
  end
end
