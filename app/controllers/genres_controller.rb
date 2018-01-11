class GenresController < ApplicationController
  before_action :ensure_logged_in

  def index
    @genres = Genre.all
    
  end

  def show
  end
end
