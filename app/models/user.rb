class User < ApplicationRecord
  validates :username, :email, :password, :presence => true
  validates :username, :length => { :maximum => 10 }
  has_secure_password

  validates :password, 
            :length => { :in => 8..24 }, 
            :allow_nil => true
end
