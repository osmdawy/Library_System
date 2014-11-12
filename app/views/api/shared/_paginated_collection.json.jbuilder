record_class_name = nil if defined?(:record_class_name) == nil
paginator =  PaginationPresenter.new(records, record_class_name)

json.total paginator.total
json.fetched paginator.fetched
json.remaining paginator.remaining

json.collection do
	json.array! records do |record|
		json.partial! partial_url, paginator.record_class => record
		
	end
end
