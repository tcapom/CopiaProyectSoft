class HomeController < ApplicationController
  # Remanente
  def index
  end

  # Enlista todos los usuarios que contengan el substring indicado
  # @param [string] search
  def index_users
    if params[:search]
      @users = User.where("email LIKE ?", "%#{params[:search]}%")
    else
      @users = User.all
    end
    
  end
end
