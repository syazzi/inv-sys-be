require 'rails_helper'

RSpec.describe "Api::V1::UsersController", type: :request do
  describe "GET /api/v1/users" do
    it "Load all users data" do
      get api_v1_users_path
      expect(response).to have_http_status(200)
    end
  end
end
