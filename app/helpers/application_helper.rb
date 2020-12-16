module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def nav_actions
    if current_user
      render 'layouts/signout'
    else
      render 'layouts/signin'
    end
  end

  def notice_display
    return unless notice.present?

    render 'layouts/notice'
  end

  def alert_display
    return unless alert.present?

    render 'layouts/alert'
  end
end
