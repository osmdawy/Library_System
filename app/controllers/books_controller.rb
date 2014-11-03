class BooksController < ApplicationController
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
  per_page = (params[:per] || 25).to_i
  query = params[:query]
	@books = Book.where(title: /.*#{query}.*/).page(page).per(per_page)
end

def create
	puts params
	@book = Book.create(:title => params[:title] , :type => params[:type] , :publish_date => params[:publish_date],:author_id =>  params[:author_id])
puts "---------------------------------------------"
	puts @book
end

def update

	end
def book_params
	params.permit(:title, :type, :password, :publish_date, :author_id)
end
end