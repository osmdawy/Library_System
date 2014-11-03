require 'carrierwave/mongoid'

class Book
	include Mongoid::Document
  include Mongoid::Timestamps
	field :title
  field :type
  field :publish_date, type: Date
  field :content
  mount_uploader :content, ContentUploader
  belongs_to :author, :class_name => "Author", :inverse_of => :books

  validates :author, :presence => true

  index({ title: 1 })

  #FTS on name
  index({"title" => 'text'})


end