class BookResource < JSONAPI::Resource
  has_one :genre

  attributes :title, :author, :published_date, :average_rating, :book_cover, :genre_id, :isbn,
             :page_count, :country_of_origin, :description, :small_thumbnail, :ny_times_list,
             :google_id, :publisher

  primary_key :isbn
end
