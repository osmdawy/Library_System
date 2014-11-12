
json.books do
	json.array! @books do |book|
		json.partial! 'api/books/book', book: book
	end
end