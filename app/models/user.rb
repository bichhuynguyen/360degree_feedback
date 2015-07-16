class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def self.search(search)
    where('user_code LIKE ? || username LIKE ? || email LIKE ? || phone LIKE ?', 
           "%#{search}%" , "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
