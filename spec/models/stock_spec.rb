require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe "#association" do
    it { expect(described_class.reflect_on_association(:item).macro).to eq :belongs_to } 
    it { expect(described_class.reflect_on_association(:department).macro).to eq :belongs_to } 
    it { expect(described_class.reflect_on_association(:vendor).macro).to eq :belongs_to } 
  end

  describe "#serial_no" do
    subject { Stock.new(item_id: 1, department_id: 1, vendor_id: 1, purchase_date: "18/03/2024", arrival_date: '18/03/2024') } 
    let(:item) {Item.new(name: "acer", category: "Laptop")}
    let(:date) {subject.purchase_date.to_s.gsub(/[-]/, '')}
    
    it "return a string of date in correct formats" do
      expect(date).to eq("20240318")
    end
    
    context "returns string of serial number" do
      it "return set of serial number" do
        stock = Stock.new(item_id: 1, department_id: 1, vendor_id: 1, purchase_date: "18/03/2024", arrival_date: '18/03/2024')
        arrival_date = stock.arrival_date
        expect(stock.serial_no).to eql("#{date}#{stock.item_id}")
      end
    end
    
    context "returns an empty string" do
      it "return empty string" do
        stock = Stock.new(item_id: 1, department_id: 1, vendor_id: 1, purchase_date: "18/03/2024", arrival_date: '18/03/2025')
        arrival_date = stock.arrival_date

        expect(stock.serial_no).to eql("")
      end
    end    
  end
  
  describe "returns status of the stocks" do
    context "return avaialble" do
      it "status is available" do
        stock = Stock.new(item_id: 1, department_id: 1, vendor_id: 1, arrival_date: '18/03/2024')
        arrival_date = stock.arrival_date
        expect(stock.status).to eql("Available")  
      end
    end
    
    context "returns staatus pending" do
      it "status is pending" do
        stock = Stock.new(item_id: 1, department_id: 1, vendor_id: 1, arrival_date: '18/03/2025')
        arrival_date = stock.arrival_date
        expect(stock.status).to eql("Pending")
      end
    end
    
    
  end
  
  
  
end
