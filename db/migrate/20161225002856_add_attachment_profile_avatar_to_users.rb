class AddAttachmentProfileAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :profile_avatar
    end
  end

  def self.down
    remove_attachment :users, :profile_avatar
  end
end
