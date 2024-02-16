class Stock < ApplicationRecord
  belongs_to :item
  belongs_to :department
  belongs_to :vendor
end
