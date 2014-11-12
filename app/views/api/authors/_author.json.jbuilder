json.id author._id.to_s
json.name author.name
json.gender author.gender
json.birth_date author.birth_date
json.books do
	json.array! author.books.map(&:id).map{|id| id.to_s}
end
