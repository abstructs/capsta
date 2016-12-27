module PostsHelper

  def image_exists?
    @post.image_file_name.nil?
  end

  def likers_of(post)
    votes = post.votes_for.up.by_type(User)

    user_names = []
    unless votes.blank?
      if votes.length <= 8
        votes.voters.each do |voter|
          user_names.push(link_to voter.user_name, profile_path(voter.user_name), class: 'user-name')
        end
        # return list of people who like this if there are less than 8 likers
        return user_names.to_sentence.html_safe + like_plural(votes)
      end
      # else return number of people who liked this
      votes.length.to_s + ' people like this'
    end
  end

  def liked_post (post)
    if current_user
      return 'glyphicon-heart' if current_user.voted_for? post
      'glyphicon-heart-empty'
    end
  end

  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end
