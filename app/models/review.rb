class Review < ActiveRecord::Base
  belongs_to :user 
  belongs_to :track


  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, uniqueness: {scope: :track_id, message: "can only review a song once!"} 

end

