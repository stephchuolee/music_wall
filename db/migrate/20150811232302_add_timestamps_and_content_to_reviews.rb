class AddTimestampsAndContentToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :created_at, :datetime
    add_column :reviews, :updated_at, :datetime 
    add_column :reviews, :title, :string 
    add_column :reviews, :content, :string 
  end
end
