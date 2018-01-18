require 'rails_helper'

RSpec.describe "UserFlows", type: :request do
  describe "GET /user_flows" do
    it "works! (now write some real specs)" do
      get user_flows_index_path
      expect(response).to have_http_status(200)
    end
  end
end
