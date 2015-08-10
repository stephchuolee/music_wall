class Track < ActiveRecord::Base
  validates :title, presence: true
  validates :artist, presence: true 
  # validates :url, 

end