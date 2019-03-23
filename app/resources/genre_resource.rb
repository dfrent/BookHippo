class GenreResource < JSONAPI::Resource
  has_many :book

  attributes :name
end
