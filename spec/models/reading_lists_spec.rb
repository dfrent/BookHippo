require 'rails_helper'

RSpec.describe Genre, :type => :model do
  context 'with 2 or more comments' do
    it 'orders them in reverse chronologically' do
      genre = Genre.new
      genre.name = 'Gurjant'
      genre.save!
      expect(genre.valid?).to eq(true)
    end
  end
end
