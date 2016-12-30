module NotificationsHelper

  def caption_string notification
    if notification.notice_type == "comment"
      "#{notification.notified_by.user_name} has #{notification.notice_type}ed on your post #{time_ago_in_words notification.created_at} ago."
    else
      "#{notification.notified_by.user_name} has #{notification.notice_type}d your post #{time_ago_in_words notification.created_at} ago."
    end
  end

end
