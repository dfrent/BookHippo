GENRES = %w[classics fantasy mystery teen art computers business entertainment fiction health history comedy romance cooking science nature sports travel culture misc].freeze

GENRES.each do |genre|
  Genre.create!(name: genre)
end

User.create!(username: 'admin', email: 'admin@bookhippo.com', password: 'password', password_confirmation: 'password')

Rake::Task['update:all'].invoke
