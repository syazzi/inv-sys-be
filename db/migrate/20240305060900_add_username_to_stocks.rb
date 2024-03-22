class AddUsernameToStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :username, :string
  end
end
