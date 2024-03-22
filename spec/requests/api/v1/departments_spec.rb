require 'rails_helper'

RSpec.describe "Api::V1::DepartmentsController", type: :request do
  let(:response_body) { JSON.parse(response.body).deep_symbolize_keys } 
  let(:department) {create(:department)}
  describe "GET /api/v1/departments" do
    it "load the departments data" do
      get api_v1_departments_path
      expect(response).to have_http_status(200)
    end

    it "returns departments" do
      FactoryBot.create(:department, name: "IT")
      FactoryBot.create(:department, name: "Finance")

      get api_v1_departments_path
      result = response_body[:data]

      expect(result.count).to eq(2)
      expect(response_body).to match_response_schema('departments', strict: true)
    end
    
  end

  describe "POST /api/v1/departments" do
    context "params is valid" do
      let(:valid_params) { {name: "IT"} } 
      it "respond with create status" do
        post api_v1_departments_path, params: valid_params
        expect(response).to have_http_status(200)
      end
  
      it "returns create json" do
        post api_v1_departments_path, params: valid_params
        expect(response_body).to eq(
          {
            "data": 
              {
                "id": (department[:id] - 1).to_s ,
                "type": "department",
                "attributes": {
                  "name": "IT"
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
      let(:invalid_params) { {name: ""} } 
      it "responds with unprocessable entity" do
        post api_v1_departments_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
      it "retruns error message for unprocessable entity" do
          post api_v1_departments_path, params: invalid_params
          expect(response_body).to match_response_schema('errors', strict: true)
      end
      
    end
    

  end
end
