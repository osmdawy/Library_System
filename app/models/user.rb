require 'carrierwave/mongoid'
require "devise/orm/mongoid"
class User

  #include mongoid
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::Rules

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  #attributes

  field :username
  field :phone
  field :gender, type: Boolean
  field :oauth_token
  field :confirmed_at, type: Time
  # field :avatar
  field :birth_date, type: Date
  #roles for user
  field :rules_mask , type: Integer ,default: 0
  set_rules :librarian, :librarian_patron
  field :oauth_token
  # has_many :sent_requests, class_name: "API::Request", foreign_key: :sender_id
  # has_many :requests, class_name: "API::Request", foreign_key: :receiver_id
 

  #indexes
  index({ email: 1 }, { unique: true})
  index({ username: 1 }, { unique: true})

  #FTS on name
  index({"username" => 'text'})

  #validations
  validates :username, :presence => true
  #validates :email, uniqueness: true
  #validates :email, format: { with: /\A\s*([-a-z0-9+._]{1,64})@((?:[-a-z0-9]+\.)+[a-z]{2,})\s*\z/i }
  validates :username, uniqueness: true, format: { with:/\A[a-zA-Z._]+([a-zA-Z._]|\d)*\Z/ }


  # # uploader
  # mount_uploader :avatar, AvatarUploader

  # attr_accessor :avatar_data, :avatar_content_type
  # before_save :decode_avatar_data
  before_create :set_oauth_token
  def gender_name
    if self.gender.present?
      return self.gender == true ? "male" : "female"
    else
      return nil
    end
  end

  # def decode_avatar_data
  #   # If avatar_data is present, it means that we were sent an image over
  #   # JSON and it needs to be decoded.  After decoding, the image is processed
  #   # normally via carrierwave.
  #   if self.avatar_data.present?
  #     data = StringIO.new(Base64.decode64(self.avatar_data))
  #     data.class.class_eval {attr_accessor :original_filename, :content_type}
  #     extension = self.avatar_content_type.split("/").last
  #     data.original_filename = "#{self.username}.#{extension}"
  #     data.content_type = self.avatar_content_type
  #     self.avatar = data
  #   end
  # end
  def set_oauth_token
    token = Devise.friendly_token[0,20]
    # while !User.find_by_oauth_token(token).nil?  do
    while !User.where(oauth_token: token).first.nil?  do
      token = Devise.friendly_token[0,20]
    end
    self.oauth_token = token
  end
	def to_builder
	   Jbuilder.new do |user|
	     user.id self._id.to_s
	     user.(self, :username)
	       # user.avatar do
	       #    user.thumb self.avatar_url(:thumb)
	       # end
	   end
	 end
end
