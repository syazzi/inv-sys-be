class AddLocationToStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :location, :string
  end
end
