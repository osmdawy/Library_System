json.meta do
json.total_pages @total_pages
end
json.books do

json.partial! 'api/shared/paginated_collection', records: @books, partial_url: 'api/books/book'

end
