class User < ActiveRecord::Base
  has_many :tracks 
  has_many :votes
  has_many :reviews

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  # saved code:
  # def voted?(track_id)
  #   votes.any? { |vote| vote.track_id == track_id }
  # end 

  
  def has_reviewed?(track_id)
    !!reviews.find_by(track_id: track_id)
    # self.id 
  end 


end 

