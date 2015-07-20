class User < ActiveRecord::Base
  belongs_to :team
  belongs_to :role
  has_many :versions
  accepts_nested_attributes_for :versions, allow_destroy: true, reject_if: :all_blank
  

  # attr_accesible :version, :comment, :versions_attributes 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :cv,
                    :url  => "/CVs/:id/:basename.:extension",
                    :path => ":rails_root/public/CVs/:id/:basename.:extension"

  # validates_attachment_presence :file
  validates_attachment_size :cv, 
                            :less_than => 300.megabytes
  validates_attachment_content_type :cv, 
                                    :content_type => ['application/pdf', 'application/msword', 'text/plain'],
                                    :message => "Only PDF, WORD or TEXT files are allowed."
 has_attached_file :avatar, styles: {large: "600x600>", medium: "300x300>", thumb: "150x150#"}
 validates_attachment_content_type :avatar, content_type: /\Aimage/
  # def self.search(search)
  #   where('user_code LIKE ? || username LIKE ? || email LIKE ? || phone LIKE ?', 
  #          "%#{search}%" , "%#{search}%", "%#{search}%", "%#{search}%")
  # end
end
