class AddUserNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_name, :string
  end

  add_index :users, :user_name, unique: true
end
