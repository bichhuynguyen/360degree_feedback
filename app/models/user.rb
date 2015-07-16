class User < ActiveRecord::Base
  def self.search(search)
    where('user_code LIKE ? || username LIKE ? || email LIKE ? || phone LIKE ?', 
           "%#{search}%" , "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
