class AddUpvoteDownvoteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :upvotes, :integer
    add_column :posts, :downvotes, :integer
  end
end
