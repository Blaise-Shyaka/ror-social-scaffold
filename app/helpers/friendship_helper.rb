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
    invitations = []

    if invites.any?
      invites.each do |inv|
        p inv
        status = ''
        if inv.status
          status = 'You are friends!'
        else
         invitations << inv
        end
        name = inv.sender.name
        list_items = (content_tag :li, "#{name} | #{status}")
        markup << list_items
      end
    else
      text = "You haven't yet sent any invitation requests!"
      markup << (content_tag :li, text)
    end

    if invitations.any?
      return render 'handle_request', invitations: invitations
    end

    markup.html_safe
  end
end