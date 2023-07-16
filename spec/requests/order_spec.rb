require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/order/new"
      expect(response).to have_http_status(:success)
    end
  end

end
