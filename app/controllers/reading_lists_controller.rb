class ReadingListsController < ApplicationController
  before_action :ensure_logged_in

  def index
  end

  def show
  end

  def new
  end

  def create
    @book = Book.find_by(params[:id])
    @existing_list = ReadingList.find_by(user_id: params[:user_id], book_id: params[:book_id])

    if @existing_list.nil?
      @reading_list = ReadingList.create(
                                         user_id: params[:user_id],
                                         book_id: params[:book_id],
                                         read_status: params[:read_status]
                                        )
    else
      @existing_list.read_status = params[:read_status]
      @existing_list.save
    end
      if request.xhr?
        p "helloooooooooooooooooooo"
        @reviews = Review.all
        render partial: "reviews/reviews_form", locals: {book: @book, review: Review.new }
      # respond_to do |format|
      #   format.html {render partial: "reviews/reviews_form", locals: {book: @book, review: Review.new} }
      #   format.js
      # end
    else
      p "hiiiiiiiiiiiiiiiiiiiiii"
      format.html {redirect_to @book}
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
