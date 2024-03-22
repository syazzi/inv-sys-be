class StockSerializer
  include FastJsonapi::ObjectSerializer
  attributes :purchase_date, :arrival_date, :quantity, :price_per_unit, :username, :location, :image_url, :description, :status, :serial_no, :item_id

  attribute :item_name do |object|
    object.item.name if object.item.present?
  end

  attribute :item_category do |object|
    object.item.category if object.item.present?
  end

  attribute :department_name do |object|
    object.department.name if object.department.present?
  end

  attribute :vendor_name do |object|
    object.vendor.name if object.vendor.present?
  end
  
end
