class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :category
  has_many :stocks

end
