class RenameColumnReceiverId < ActiveRecord::Migration[5.2]
  def change
    rename_column :friendships, :receiver_id, :friend_id
  end
end
