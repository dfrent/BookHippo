class SearchforController < ApplicationController


  def search_for
    @user = User.all
    @books = []
    @isbn = result["book_details"][0]["primary_isbn10"]

    if params[:search]
    @user = user.search_for(params[:search])
      if @user.length > 0
        render
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end


end
