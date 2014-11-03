require 'carrierwave/mongoid'

class Image
	include Mongoid::Document
	include Mongoid::Timestamps

	field :image

	mount_uploader :image, ImageUploader

	belongs_to :uploadable, :polymorphic => true  

end