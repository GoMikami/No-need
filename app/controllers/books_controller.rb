class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_book,only: [:edit]

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
  end

  def new
    @book =Book.new
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def correct_book
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user.id == current_user.id
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
