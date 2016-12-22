module PostsHelper

  def image_exists?
    @post.image_file_name.nil?
  end

end
