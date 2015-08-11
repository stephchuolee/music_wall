class Vote < ActiveRecord::Base
  belongs_to :user 
  belongs_to :track

  validates :user_id, uniqueness: {scope: :track_id, message: "can only upvote a song once!"} #cannot save a new vote object in the table



end