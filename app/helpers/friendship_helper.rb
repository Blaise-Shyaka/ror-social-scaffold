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

  def display_friendships(requests)
    markup = ''
    status_message1 = 'You are friends!'
    status_message2 = 'Request Pending'
    status_message3 = 'Request Rejected'

    if requests.any?
      requests.each do |req|
        name = req.receiver.name
        status = friendship_status(req, status_message1, status_message2, status_message3)
        list_items = (content_tag :li, "#{name} | #{status}")
        markup << list_items
      end
    else
      text = "You haven't yet sent any friendship requests!"
      markup << (content_tag :li, text)
    end

    markup.html_safe
  end

  def display_invitations(invites)
    markup = ''

    if invites.any?
      invites.each do |inv|
        status_message1 = 'You are friends!'
        status_message2 = "<span><%= link_to 'Accept Request', accept_friendship_path(#{inv.id}), method: :put %></span>
                      <span><%= link_to 'Reject Request', reject_friendship_path(#{inv.id}), method: :put %></span>"
        status_message3 = "<span><%= link_to 'Accept Request', accept_friendship_path(#{inv.id}), method: :put %></span>"

        name = inv.sender.name
        status = friendship_status(inv, status_message1, status_message2, status_message3)
        list_items = (content_tag :li, "#{name} | #{status}")
        markup << list_items
      end
    else
      text = "You haven't yet sent any invitation requests!"
      markup << (content_tag :li, text)
    end

    markup.html_safe
  end
end