class SearchForController < ApplicationController
  def search_for
    redirect_to root_url unless params[:search]
    query = params[:search].downcase
    google = Tools::Google.new

    @user = User.where(' username LIKE ? ', "%#{query}%")
    @google_items = google.book_search(query)
    return unless @google_items

    ###########

    @books = []

    @google_items[0..19].each do |result|
      isbn = google.isbn_10_from_api(result['volumeInfo']['industryIdentifiers'])
      if isbn
        google.isbn = isbn
        book = google.find_or_api_call
        next if book.nil?
      else
        next
      end
      @books << book
    end
    render :index
  end
end
