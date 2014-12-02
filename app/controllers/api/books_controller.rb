class Api::BooksController < ApplicationController
  respond_to :json
   # ===================== Documentation ==================
    # GET, '/books', "list books based on a search query
    #  - friend_request: The user have sent a friend request to the current user"
    # param :query, String, :desc => "the search query for the title", :required => false
    # param :page, Integer, :desc => "pagination index for users, default = 1"
    # param :per, Integer, :desc => "number of users returned per search, default = 25"
    # ======================================================
  def index
  	page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 25).to_i
    query = params[:query]

  	@books = Book.where(title: /.*#{query}.*/).page(page).per(per_page)
    @total_pages = ((@books.total_count*1.0)/per_page).ceil
  end
  def show
    id = params[:id]
    @book = Book.where(id: id).first
  end
  def create
    puts "-------------------------------------------------------------------"
    puts params
    puts "--------------------------------------------------------------------"
    # book_params = params[:book]
  	@book = Book.create(book_params)
  end

  def update

    @book = Book.where(id: params[:id]).first
    @book.update(book_params)
  end
  
  def book_params
  	params.require(:book).permit(:title, :type, :publish_date, :author_id,:content)
  end
end