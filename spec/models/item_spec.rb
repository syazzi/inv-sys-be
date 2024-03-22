require 'rails_helper'

RSpec.describe Item, type: :model do 
  let(:department) { create(:department) } 
    let(:item) { create(:item) }
    let(:vendor) { create(:vendor) } 
  describe "#association" do
    it "item has many stock" do
      expect(described_class.reflect_on_association(:stocks).macro).to eq :has_many 
    end
    
  end
  
  describe "#current_stock" do    
    it "returns sum of current stock" do
      stock = Stock.new(item_id: 1, department_id: 1, vendor_id: 1, arrival_date: "18/03/2024", quantity: 5)
      item = Item.new(name: "acer", category: "Laptop")
      sum_of_current_stock = 0
      date = stock.arrival_date
      quantity = stock.quantity
      if date <= Date.today || !date.nil?
        sum_of_current_stock += quantity
      end
      expect(sum_of_current_stock).to eq(5)
    end

    context "arrival date is less than today and not nil" do    
      let!(:stocks) do
        [
          create(:stock, item: item, department: department, vendor: vendor, arrival_date: Date.new(2024, 3, 18), quantity: 5),

        ]
      end
    
      let!(:items) { item }
    
      it "returns quantity" do
        expect(items.current_stock).to eq(5)
      end
    end

    context "arrival date is greater than today" do
      let!(:stocks) do
        [
          create(:stock, item: item, department: department, vendor: vendor, arrival_date: Date.new(2030, 3, 18), quantity: 5),

        ]
      end
    
      let!(:items) { item }
    
      it "returns quantity" do
        expect(items.current_stock).to eq(0)
      end
    end
  end
  
  
  describe "#ordered_stock" do
    it "gives ordered stock if arrival date is greater than today" do
      stock = Stock.new(item_id: 1, department_id: 1, vendor_id: 1, arrival_date: "18/03/2024", quantity: 5)
      item = Item.new(name: "acer", category: "Laptop")
      sum_of_ordered_stock = 0
      date = stock.arrival_date
      quantity = stock.quantity
      if date > Date.today || date.nil?
        sum_of_ordered_stock += quantity
      end
      expect(sum_of_ordered_stock).to eq(0)  
    end
    
    context "arrival date is greater than todays date" do
      let!(:stocks) do
        [
          create(:stock, item: item, department: department, vendor: vendor, arrival_date: Date.new(2050, 3, 18), quantity: 5),

        ]
      end
    
      let!(:items) { item }
    
      it "returns quantity" do
        expect(items.current_stock).to eq(0)
      end
    end

    context "arrival date is less than todays date" do
      let!(:stocks) do
        [
          create(:stock, item: item, department: department, vendor: vendor, arrival_date: Date.new(2024, 3, 18), quantity: 5),

        ]
      end
    
      let!(:items) { item }
    
      it "returns quantity" do
        expect(items.current_stock).to eq(5)
      end
    end
  end
  
  
  
end
