class Stock < ApplicationRecord
  belongs_to :item
  belongs_to :department
  belongs_to :vendor

  def status
    arrival_date && arrival_date <= Date.today ? "Available" : "Pending"
  end

  def serial_no
    date = purchase_date.to_s.gsub(/[-]/, '')
    arrival_date && arrival_date <= Date.today ? "#{date}#{item_id}" : ""
  end
  
end
