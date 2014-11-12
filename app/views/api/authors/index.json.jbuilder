json.authors do
	json.array! @authors do |author|
		json.partial! 'api/authors/author', author: author
	end
end