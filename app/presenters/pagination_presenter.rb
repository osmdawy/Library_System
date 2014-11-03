class PaginationPresenter

  attr_reader :collection
  attr_reader :record_class_name


  def initialize(collection,record_class_name='')
    @collection = collection
    @record_class_name = record_class_name
  end

  def total
    @collection.total_count
  end

  def fetched
    @collection.count(true)
  end

  def remaining
    if @collection.last_page?
      return 0
    end
    current_page = @collection.current_page
    return self.total - (current_page * self.fetched)
  end

  def record_class
      if @record_class_name.nil?
        name = @collection.first.class.to_s
        name.underscore.to_sym
      else 
        @record_class_name.to_sym
      end 
  end

end
