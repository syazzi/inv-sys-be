require 'rails_helper'

RSpec.describe "Api::V1::StocksController", type: :request do
  let(:item)  {create(:item)}
    let(:department) {create(:department)}
    let(:vendor) {create(:vendor)}
    let(:stock) {create(:stock, item: item, department: department, vendor: vendor )} 
  let(:response_body) { JSON.parse(response.body).deep_symbolize_keys }
  before(:each) do
    @current_user = create(:user)
  end

  def login
    post user_session_path, params:  { email: @current_user.email, password: 'password' }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token-type' => token_type
    }
    auth_params
  end

  describe "GET /api/v1/stocks" do
    it "Load all records of stocks" do
      get api_v1_stocks_path
      expect(response).to have_http_status(200)
    end

    it "returns stocks" do
      FactoryBot.create(:stock, item: item, department: department, vendor: vendor)
      FactoryBot.create(:stock, item: item, department: department, vendor: vendor)

      get api_v1_stocks_path
      result = response_body[:data]

      expect(result.count).to eq(2)
      expect(response_body).to match_response_schema('stocks', strict: true)
    end
  end
  describe "GET /api/v1/stocks/:id" do
    it "responds 200 get id" do  
      get "/api/v1/stocks/#{stock.id}"
      expect(response).to have_http_status(200)
    end

    it "return json on show records" do
      get "/api/v1/stocks/#{stock.id}"
      result = response_body[:data]

      expect(result[:id]).to eq(stock.id.to_s)
      expect(result[:attributes][:department_name]).to eq(department.name)
      expect(result[:attributes][:vendor_name]).to eq(vendor.name)
      expect(result[:attributes][:item_name]).to eq(item.name)

    end
    
  end
  describe "POST /api/v1/stocks" do
    it "respond to ok" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      params = {
        item_id: item[:id], department_id: department[:id], vendor_id: vendor[:id],
        }
      post api_v1_stocks_path, params: params, headers: auth_params
      expect(response).to have_http_status(:ok)
    end

    it "returns stock json" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      params = {
        item_id: item[:id], department_id: department[:id], vendor_id: vendor[:id],
        }
      post api_v1_stocks_path, params: params, headers: auth_params
      expect(response_body).to eq(
        {
          "data": {
            "id": (stock[:id] - 1).to_s,
            "type": "stock",
            "attributes": {
              "purchase_date": nil,
              "arrival_date": nil,
              "quantity": nil,
              "price_per_unit": nil,
              "username": nil,
              "location": nil,
              "image_url": nil,
              "description": nil,
              "status": "Pending",
              "serial_no": "",
              "item_id": item[:id],
              "item_name": item[:name],
              "item_category": item[:category],
              "department_name": department[:name],
              "vendor_name": vendor[:name]
            }
          }
        }
      )
    end
  end

  describe "DELETE /api/v1/stocks/:id" do 
    it "respond with ok" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      delete "/api/v1/stocks/#{stock[:id]}", headers: auth_params
      expect(response).to have_http_status(200)
    end
    it "returns the deleted data in json" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      delete "/api/v1/stocks/#{stock[:id]}", headers: auth_params
      expect(response_body).to eq(
        {
          "data": {
            "id": stock[:id].to_s,
            "type": "stock",
            "attributes": {
              "purchase_date": nil,
              "arrival_date": nil,
              "quantity": nil,
              "price_per_unit": nil,
              "username": nil,
              "location": nil,
              "image_url": nil,
              "description": nil,
              "status": "Pending",
              "serial_no": "",
              "item_id": item[:id],
              "item_name": item[:name],
              "item_category": item[:category],
              "department_name": department[:name],
              "vendor_name": vendor[:name]
            }
          }
        }
      )
    end
    
  end
  describe "PUT /api/v1/stocks/:id" do
     
    it "responds with ok" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      params = {
        arrival_date: "20/02/2024", location: "lot A", description: "lorem", username: @current_user.email
      }
      put "/api/v1/stocks/#{stock.id}", params: params, headers: auth_params
      expect(response).to have_http_status(200) 
    end

    it "returns the updated stock json" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      params = {
        arrival_date: "20/02/2024", location: "lot A", description: "lorem", username: @current_user.email
      }
      put "/api/v1/stocks/#{stock.id}", params: params, headers: auth_params
      expect(response_body).to eq(
        {
          "data": {
            "id": stock[:id].to_s,
            "type": "stock",
            "attributes": {
              "purchase_date": nil,
              "arrival_date": "2024-02-20",
              "quantity": nil,
              "price_per_unit": nil,
              "username": @current_user.email,
              "location": "lot A",
              "image_url": nil,
              "description": "lorem",
              "status": "Available",
              "serial_no": item[:id].to_s,
              "item_id": item[:id],
              "item_name": item[:name],
              "item_category": item[:category],
              "department_name": department[:name],
              "vendor_name": vendor[:name]
            }
          }
        }
      ) 
    end
    
  end
end
