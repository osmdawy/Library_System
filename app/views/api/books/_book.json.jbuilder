json.id book._id.to_s
json.title book.title
json.type book.type
json.publish_date book.publish_date
json.image_path book.content.path
json.author book.author._id.to_s
