class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
    @bookcomment = BookComment.new
    @readcount = ReadCount.find_or_create_by(user_id: current_user.id, book_id: @book.id) do |readcount|
      readcount.count = 0
    end
    @readcount.increment!(:count)
    @countmeter = @readcount.count
  end

  def index
    @booknew = Book.new
    
    if params[:latest]
      @books = Book.latest
    elsif params[:old]
      @books = Book.old
    elsif params[:favorites_count]
      @books = Book.favorites_count
    else
      @books = Book.all
    end

    @six = Book.sixago.count
    @five = Book.fiveago.count
    @four = Book.fourago.count
    @three = Book.threeago.count
    @two = Book.twoago.count
    @one = Book.yesterday.count
    @today = Book.today.count

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


  def is_matching_login_user
    user = Book.find(params[:id])
    unless user.user_id == current_user.id
      redirect_to books_path
    end
  end
end
