class Track < ActiveRecord::Base
  belongs_to :user 

  validates :title, presence: true
  validates :artist, presence: true 
  validates :url, format: { with: /\A(https?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/, message: "Please append 'http://' or 'https://' "}, :allow_blank => true

end

