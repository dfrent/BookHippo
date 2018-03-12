require 'rails_helper'
RSpec.configure do |config|
  config.filter_rails_from_backtrace!
end

RSpec.describe StatusController, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response.status).to eq(200)
    end
  end
end

RSpec.describe ReadingListsController, type: :controller do
  describe "GET index" do
    it "User must be logged in to view index of reading controller" do
      get :index
      expect(response.status).to eq(302)
    end
  end
end

RSpec.describe Genre, :type => :model do
  context "with 2 or more comments" do
    it "orders them in reverse chronologically" do
      genre = Genre.new
      genre.name = "Gurjant"
      genre.save!
      expect(genre.valid?).to eq(true)
    end
  end
end

# NY TIMES API's
feature 'NY Times Top Books' do
  it 'queries FactoryGirl contributors on GitHub' do
    uri = URI("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=mass-market-paperback")
    response = Net::HTTP.get(uri)
    responserubyhash = JSON.parse(response)
    expect(responserubyhash["status"]).to eq("OK")
  end
end

feature 'NY Times Top Travel' do
  it 'API Response Success' do
    uri = URI("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=travel")
    response = Net::HTTP.get(uri)
    responserubyhash = JSON.parse(response)
    expect(responserubyhash["status"]).to eq("OK")
  end
end

feature 'NY Times Top Science' do
  it 'API Response Success' do
    uri = URI("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=science")
    response = Net::HTTP.get(uri)
    responserubyhash = JSON.parse(response)
    expect(responserubyhash["status"]).to eq("OK")
  end
end

feature 'NY Times Top Business' do
  it 'API Response Success' do
    uri = URI("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=business-books")
    response = Net::HTTP.get(uri)
    responserubyhash = JSON.parse(response)
    expect(responserubyhash["status"]).to eq("OK")
  end
end

feature 'NY Times Top Animals' do
  it 'API Response Success' do
    uri = URI("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=animals")
    response = Net::HTTP.get(uri)
    responserubyhash = JSON.parse(response)
    expect(responserubyhash["status"]).to eq("OK")
  end
end
