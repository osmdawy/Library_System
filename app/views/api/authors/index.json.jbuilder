json.authors do

json.partial! 'api/shared/paginated_collection', records: @authors, partial_url: 'api/authors/author'

end
