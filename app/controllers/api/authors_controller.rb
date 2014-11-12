class Api::AuthorsController < ApplicationController
respond_to :json

def index
	@authors = Author.all
end

def show
id = params[:id]
@author = Author.where(id: id).first
end
def create
	@author = Author.create(:name => params[:name],:gender => params[:gender],:birth_date => params[:birth_date])
end

end