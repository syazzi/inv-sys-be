class Item < ApplicationRecord
    validates :name, :category, presence: true
    has_many :stocks

    def current_stock
        sum_of_current_stock = 0
        selected_stocks = stocks.select { |stock| stock.arrival_date&. <= Date.today || !stock.arrival_date.nil?}
        selected_stocks.each do |current_stock|
            sum_of_current_stock += current_stock.quantity
        end
        selected_stocks.count.positive? ? sum_of_current_stock : 0
    end

    def ordered_stock
        sum_of_ordered_stock = 0
        selected_stocks = stocks.select { |stock| stock.arrival_date.nil? || stock.arrival_date > Date.today}
        selected_stocks.each do |ordered_stock|
            sum_of_ordered_stock += ordered_stock.quantity
        end
        selected_stocks.count.positive? ? sum_of_ordered_stock : 0
    end
end
