class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes 
  end
end
