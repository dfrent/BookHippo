class ReadingListsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @book = Book.find(params[:book_id])
    @existing_list = find_or_create_list

    if request.xhr?

      @reviews = Review.where(book_id: params[:book_id])

      @rating = Rating.where(book_id: params[:book_id], user_id: current_user)
      puts "...........................................#{@rating.inspect}"

      if @rating == nil
        @rating = Rating.new
        @rating.stars = 0
      end
      render partial: 'reviews/reviews_form', locals: { book: @book, review: Review.new, rating: @rating }
    else
      format.html { redirect_to book_path(@book[:isbn]) }
    end
  end

  private

  def find_or_create_list
    list = ReadingList.find_by(user_id: params[:user_id], book_id: params[:book_id])
    if list
      list.update_attribute(:read_status, params[:read_status])
      list
    else
      ReadingList.create(user_id: params[:user_id],
                         book_id: params[:book_id],
                         read_status: params[:read_status])
    end
  end
end
