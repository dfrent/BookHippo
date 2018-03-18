class SearchForController < ApplicationController
  def search_for
    @books = []
    # @users = User.find_user(:search)
    if params[:search]
      @user = User.find_user(params[:search].downcase)
      Rails.logger.info(@user.inspect)

      goog_response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{params[:search]}&key=#{ENV['GBOOKS_KEY']}")

      @google_items = goog_response.parsed_response['items']

      if @google_items
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
      end
      render :index
    else
      redirect_to root_url
    end
  end
end
