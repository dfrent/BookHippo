class SearchForController < ApplicationController

  def search_for
    @books = []
      @users = User.all
      if params[:search]
      @user = User.find_user(params[:search])

      goog_response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{params[:search]}&key=#{ENV['GBOOKS_KEY']}") #


        goog_response.parsed_response["items"][0..5].each do |result|
          if result["volumeInfo"]["imageLinks"]
            book_img = result["volumeInfo"]["imageLinks"]["smallThumbnail"]
          end

          if result["volumeInfo"]["industryIdentifiers"][0]["type"]
          result_type = result["volumeInfo"]["industryIdentifiers"][0]["type"]

          result_identifier = result["volumeInfo"]["industryIdentifiers"][0]["identifier"]
            if result_type == "OTHER"
              result_identifier = result_identifier.split(':')[1]
            end
            authors = result["volumeInfo"]["authors"]
            author_string = authors.join(", ")


          @books << { title: result["volumeInfo"]["title"], author: author_string ,description: result["volumeInfo"]["description"],isbn: result_identifier, book_image: book_img }
          end
        end

          if @user.length > 0 || @books.length > 0
            render :index
          else
            redirect_to root_url
          end
      else
        redirect_to root_url
      end
    end


end
