if @book.errors.any?
  json.partial! 'layouts/errors', errors: @book.errors
  json.status false
else
  json.partial! 'books/book', book: @book
  json.status true
end