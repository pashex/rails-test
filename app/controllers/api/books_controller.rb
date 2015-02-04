class Api::BooksController < ApplicationController
  before_action :load_book, only: [:show, :update, :destroy]

  def index
    render json: Book.all, status: :ok
  end
  
  def show
    render json: book, status: :ok
  end

  def create
    @book = Book.new
    update_book
  end

  def update
    update_book
  end

  def destroy
    book.destroy
    head 204
  end

  private

  def book
    @book ||= Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head 404
  end
  alias_method :load_book, :book
  
  def update_book
    book.attributes = book_params
    if book.save
      render json: book, status: :ok
    else
      render json: book.errors, status: 422
    end
  end
  
  def book_params
    params.require(:book).permit(:name, :description, :release_date)    
  end
end
