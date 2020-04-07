require 'rails_helper'

RSpec.describe "Bests", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/bests/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/bests/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/bests/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/bests/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
