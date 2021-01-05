module FriendshipHelper
  def friendship_status(friendship, status_msg1, status_msg2, status_msg3)
    if friendship.status
      status_msg1
    elsif friendship.status.nil?
      status_msg2
    else
      status_msg3
    end
  end

  def display_all_friends(friends)
    markup = ''

    if friends.any?
      friends.each do |req|
        name = req.name
        list_items = (content_tag :li, "#{name}")
        markup << list_items
      end
    else
      text = "You have no friends yet!"
      markup << (content_tag :li, text)
    end

    markup.html_safe
  end

  def display_invitations(invites)
    markup = ''

    if invites.none?
      text = "You have no pending invitations!"
      markup << (content_tag :li, text)
      return markup.html_safe
    end

    render 'handle_request', invitations: invites
  end

  def display_requests(requests)
    markup = ''

    if requests.any?
      requests.each do |req|
        name = req.name
        list_items = (content_tag :li, "#{name}")
        markup << list_items
      end
    else
      text = "You have no pending requests!"
      markup << (content_tag :li, text)
    end

    markup.html_safe
  end
end
