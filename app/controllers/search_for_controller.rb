class SearchForController < ApplicationController

  def search_for
    @books = []
      @user = User.all
      if params[:search]
      @user = User.find_user(params[:search])

      goog_response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{params[:search]}&key=#{ENV['GBOOKS_KEY']}")


        goog_response.parsed_response["items"][0..5].each do |result|

          book_img = result["volumeInfo"]["imageLinks"]["smallThumbnail"]
          @books << { title: result["volumeInfo"]["title"], author: result["volumeInfo"]["authors"], description: result["volumeInfo"]["description"], isbn: result["volumeInfo"]["industryIdentifiers"][1]["identifier"], book_image: book_img }


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
