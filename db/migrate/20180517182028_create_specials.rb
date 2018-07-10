class CreateSpecials < ActiveRecord::Migration[5.0]
  def change
    create_table :specials do |t|
      t.string :link
      t.string :produce_link
      t.date :good_thru

      t.timestamps
    end
  end
end
