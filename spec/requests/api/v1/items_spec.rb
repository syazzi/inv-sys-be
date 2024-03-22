require 'rails_helper'

RSpec.describe "Api::V1::ItemsController", type: :request do
  let(:response_body) { JSON.parse(response.body).deep_symbolize_keys } 
  describe "GET /api/v1/items" do
    it "Load all items" do
      get api_v1_items_path
      expect(response).to have_http_status(200)
    end

    it "returns items" do
      FactoryBot.create(:item, name: "Acer", category: "Laptop")
      FactoryBot.create(:item, name: "Maze Runner", category: "Book")

      get api_v1_items_path
      result = response_body[:data]

      expect(result.count).to eq(2)
      expect(response_body).to match_response_schema('items', strict: true)
    end
  end

  describe "POST /api/v1/items" do
    let(:item) {create(:item)}
    let(:valid_params) { {name: "Acer", category: "Laptop"} }
    context "if params is valid" do
      it "responds with ok" do
        post api_v1_items_path, params: valid_params
        expect(response).to have_http_status(200)
      end
  
      it "returns item json" do
        post api_v1_items_path, params: valid_params
        expect(response_body).to eq(
          {
           "data": {
             "id": (item[:id]-1).to_s,
             "type": "item",
             "attributes": {
               "name": "Acer",
               "category": "Laptop",
               "current_stock": 0,
               "ordered_stock": 0
             },
             "relationships": {
               "stocks": {
                 "data": [
  
                 ]
               }
             }
           }
         }
        )
      end
    end
    
    context "if params is invalid" do
      let(:invalid_params) { {name: "", category: ""} } 
      it "responds with unprocessable entity" do
        post api_v1_items_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
      it "returns errors json" do
        post api_v1_items_path, params: invalid_params
        expect(response_body).to match_response_schema("errors", strict: true)
      end
    end
  end
end
