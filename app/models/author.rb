
class Author

  #include mongoid
  include Mongoid::Document
  include Mongoid::Timestamps

 

  #attributes

  field :name
  field :gender, type: Boolean
  field :birth_date, type: Date
  
  
  #relations
  has_many :books, class_name: "Book", foreign_key: "author_id", :inverse_of => :author
 
  

  def gender_name
    if self.gender.present?
      return self.gender == true ? "male" : "female"
    else
      return nil
    end
  end

 
  def to_builder
   Jbuilder.new do |author|
     author.id self._id.to_s
     author.(self, :name)
   end
 end
end
