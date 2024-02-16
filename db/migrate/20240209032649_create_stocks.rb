class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.references :item
      t.references :department
      t.date :purchase_date
      t.date :arrival_date
      t.references :vendor
      t.integer :quantity
      t.float :price_per_unit
      t.string :image_url
      t.string :description

      t.timestamps
    end
  end
end
