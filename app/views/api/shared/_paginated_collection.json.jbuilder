record_class_name = nil if defined?(:record_class_name) == nil
paginator =  PaginationPresenter.new(records, record_class_name)


	json.array! records do |record|
		json.partial! partial_url, paginator.record_class => record
		
	end