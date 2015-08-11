class User < ActiveRecord::Base
  has_many :tracks 
  has_many :votes

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  # saved code:
  # def voted?(track_id)
  #   votes.any? { |vote| vote.track_id == track_id }
  # end 

  
  


end 

