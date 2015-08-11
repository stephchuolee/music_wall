class User < ActiveRecord::Base
  has_many :tracks 
  has_many :votes

  validates :email, uniqueness: true
  validates :password, presence: true



end 

