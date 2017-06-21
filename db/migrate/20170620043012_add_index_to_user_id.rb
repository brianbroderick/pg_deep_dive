class AddIndexToUserId < ActiveRecord::Migration[5.0]
  def change
    add_index :logins, :user_id
  end
end
