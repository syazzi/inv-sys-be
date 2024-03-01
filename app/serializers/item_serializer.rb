class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :category, :current_stock, :ordered_stock
  has_many :stocks

end
