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
    @reading_list = ReadingList.new
    @reading_list.book_id = params[:book_id]
    @reading_list.read_status = params[:read_status]
    current_user.reading_lists << @reading_list
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
