class RenameSenderColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :friendships, :sender_id, :user_id
  end
end
