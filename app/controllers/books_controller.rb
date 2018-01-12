class BooksController < ApplicationController
  def index
    @books = Book.where("ny_times_list = ?", "Mass Market Paperback")
    @books_travel = Book.where("ny_times_list = ?", "Travel")
    @books_science = Book.where("ny_times_list = ?", "Science")
    @books_business = Book.where("ny_times_list = ?", "Business Books")
    @books_animals = Book.where("ny_times_list = ?", "Animals")
  end

  def show
    isbn = params[:id]
    @book = Book.find_or_api_call(isbn)
    @reading_list = ReadingList.new
    @existing_list = ReadingList.find_by(user_id: current_user.id, book_id: @book.id)
    @review = Review.new
    @reviews = @book.reviews.all
  end

  def edit
  end

  def update
  end

  def recommendations
    @user = current_user
    @books = []

    user_genres = @user.genres

    user_genres.each do |genre|
      name = genre.name
      response =  HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=subject=#{name}&key=#{ENV['GBOOKS_KEY']}")
      items = response.parsed_response["items"]

      items.each do |item|
        # info = item["volumeInfo"]
        # authors = info["authors"]
        # # google_id = response.parsed_response["items"][item]["id"]
        # if info["industryIdentifiers"][1] != nil && authors != nil && info["title"] != nil
        #   isbn = info["industryIdentifiers"][1]["identifier"]
        #   authors_string = authors.join(", ")
        #   new_book = Book.create(isbn: isbn, title: info["title"], author: authors_string, description: info["description"], book_cover: info["imageLinks"]["thumbnail"], small_thumbnail: info["imageLinks"]["smallThumbnail"], genre_id: 1, page_count: info["pageCount"], average_rating: info["averageRating"], published_date: info["publishedDate"], publisher: info["publisher"])




        # end

        @books << item
        # @books << new_book

      end

    end
    console
  end
end
