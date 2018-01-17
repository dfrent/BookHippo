require 'rails_helper'

RSpec.describe ReadingListsController, type: :controller do

  describe "GET create" do


    it "User must be logged in to create a reading controller" do
      get :create
      expect(response.status).to eq(302)
    end
  end





  describe "GET index" do
    it "User must be logged in to view index of reading controller" do
      get :index
      expect(response.status).to eq(302)
    end
  end



end
