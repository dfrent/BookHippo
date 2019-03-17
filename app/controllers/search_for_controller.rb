class SearchForController < ApplicationController
  def search_for
    redirect_to root_url unless params[:search]
    query = params[:search].downcase
    google = Tools::Google.new

    @user = User.where(' username LIKE ? ', "%#{query}%")
    @google_items = google.book_search(query)
    return unless @google_items

    ###########

    @books = @google_items[0..19].each_with_object([]) do |item, items|
      isbn = google.isbn_10_from_api(item['volumeInfo']['industryIdentifiers'])
      next unless isbn

      google.isbn = isbn
      book = google.find_or_api_call
      next if book.nil?

      items << book
    end
    render :index
  end
end
