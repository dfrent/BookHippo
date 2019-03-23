class GenreResource < JSONAPI::Resource
  has_many :books

  attributes :name
end
