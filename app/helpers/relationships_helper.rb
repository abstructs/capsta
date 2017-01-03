module RelationshipsHelper
  def current_user_is_following(user_name)
    if current_user.following.find_by(user_name: user_name).nil?
      return false
    else
      return true
    end
  end
end
