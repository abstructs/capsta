module ApplicationHelper
  def alert_for(flash_type)
    { success: 'alert-success',
    error: 'alert-danger',
    alert: 'alert-warning',
    notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def profile_avatar_select user
    if user.profile_avatar_file_name.nil?
      image_tag 'default-avatar.png', id: 'image-preview', class: 'img-responsive img-circle profile-image'
    else
      return image_tag user.profile_avatar.url(:medium), id: 'image-preview', class: 'img-responsive img-circle profile-image'
    end
  end
end
