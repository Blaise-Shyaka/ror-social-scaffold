module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def all_posts(posts)
    posts_list = []
    posts.each do |p|
      friends_with_author = p.user.friends.include?(current_user)

      posts_list << p if friends_with_author || p.user == current_user
    end
    posts_list
  end
end
