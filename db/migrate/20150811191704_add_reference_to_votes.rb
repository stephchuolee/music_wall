class AddReferenceToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :user, index: true
    add_reference :votes, :track, index: true
  end
end
