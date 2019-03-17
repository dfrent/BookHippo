class SearchForController < ApplicationController
  def search_for
    redirect_to root_url unless params[:search]
    query = params[:search].downcase
    google = Tools::Google.new

    @user = User.where(' username LIKE ? ', "%#{query}%")
    @google_items = google.book_search(query)
    return unless @google_items
    @books = []
    @google_items[0..19].each do |result|
      if result['volumeInfo']['imageLinks']
        book_img = result['volumeInfo']['imageLinks']['thumbnail']
      else
        next
      end
      identifiers = result['volumeInfo']['industryIdentifiers']
      isbn = nil
      if identifiers
        identifiers.each do |identifier|
          if identifier.has_value?('ISBN_10')
            isbn = identifier['identifier']
          elsif identifier.has_value?('OTHER')
            isbn = nil
          end
        end
      end
      next if isbn == nil

      authors = result['volumeInfo']['authors']
      if authors
        authors_string = authors.join(', ')
      end
      @books << { title: result['volumeInfo']['title'], author: authors_string, description: result['volumeInfo']['description'], isbn: isbn, book_image: book_img }
    end
    render :index
  end
end
