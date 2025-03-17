class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    if favorite.save
      redirect_to request.referer
    end

  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    if favorite.destroy
      redirect_to request.referer
    end
    
  end

end
