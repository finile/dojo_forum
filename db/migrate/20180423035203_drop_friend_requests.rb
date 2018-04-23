class DropFriendRequests < ActiveRecord::Migration[5.1]
  def change
    drop_table :friend_requests
  end
end
