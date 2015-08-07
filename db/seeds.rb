class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :location
      t.string :address
      t.string :price
      t.timestamps null: false
    end
  end
end
