require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/dashboard/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /courses" do
    it "returns http success" do
      get "/dashboard/courses"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /students" do
    it "returns http success" do
      get "/dashboard/students"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /notifications" do
    it "returns http success" do
      get "/dashboard/notifications"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /messages" do
    it "returns http success" do
      get "/dashboard/messages"
      expect(response).to have_http_status(:success)
    end
  end

end
