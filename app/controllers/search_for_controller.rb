class SearchForController < ApplicationController
  GOOGLE = Tools::Google.new

  def search_for
    redirect_to root_url unless params[:search]
    query = params[:search].downcase

    @users = User.where(' username LIKE ? ', "%#{query}%")
    google_items = GOOGLE.book_search(query)
    return unless google_items

    @books = validate_book_search(google_items)
    render :index
  end

  private

  def validate_book_search(books)
    books[0..19].each_with_object([]) do |item, items|
      isbn = GOOGLE.isbn_10_from_api(item['volumeInfo']['industryIdentifiers'])
      next unless isbn

      GOOGLE.isbn = isbn
      book = GOOGLE.find_or_api_call
      next if book.nil?

      items << book
    end
  end
end
