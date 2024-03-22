require 'rails_helper'

RSpec.describe "Api::V1::VendorsController", type: :request do
  let(:response_body) { JSON.parse(response.body).deep_symbolize_keys } 
  let(:vendor) {create(:vendor)}
  let(:invalid_params) {{ name: "" }}
  describe "GET /api/v1/vendors" do
    it "Load all vendors data" do
      get api_v1_vendors_path
      expect(response).to have_http_status(200)
    end

    it "returns vendors" do
      FactoryBot.create(:vendor, name: "Huaho")
      FactoryBot.create(:vendor, name: "Yappee")

      get api_v1_vendors_path
      result = response_body[:data]

      expect(result.count).to eq(2)
      expect(response_body).to match_response_schema('vendors', strict: true)
    end
  end

  describe "POST /api/v1/vendors" do
  let(:valid_params) {{ name: "Huaho" }}
  context "if params is valid" do
    it "responds with ok" do
      post api_v1_vendors_path, params: valid_params
      expect(response).to have_http_status(200)
    end
  
    it "returns create json" do
      post api_v1_vendors_path, params: valid_params
      expect(response_body).to eq(
        {
          "data": 
            {
              "id":( vendor[:id] - 1).to_s,
              "type": "vendor",
              "attributes": {
                "name": "Huaho"
              },
              "relationships": {
                "stocks": {
                  "data": []
                }
              }
            }
        }
        
      )
    end
    
  end
  
    context "if params is invalid" do
      
      it "responds with unprocessable entity" do
        post api_v1_vendors_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
      it "retruns error message for unprocessable entity" do
          post api_v1_vendors_path, params: invalid_params
          expect(response_body).to match_response_schema('errors', strict: true)
      end
    end
  
  end
end
