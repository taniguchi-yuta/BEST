require 'rails_helper'

RSpec.describe "BestComments", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/best_comments/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/best_comments/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
