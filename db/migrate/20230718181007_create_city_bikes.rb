class CreateCityBikes < ActiveRecord::Migration[7.0]
  def change
    create_table :city_bikes do |t|
      t.string :name
      t.string :company
      t.references :country, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
