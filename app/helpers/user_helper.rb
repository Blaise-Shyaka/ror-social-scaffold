module UserHelper
  def display_status_or_call_to_action_links(user)
    markup = ''
    if current_user.friends.include?(user)
      markup << 'You are friends'
    elsif current_user.pending_requests.include?(user)
      markup << 'Pending request'
    elsif current_user.invitation_requests.include?(user)
      invitation = Friendship.where(user_id: user.id, friend_id: current_user.id)
      return render 'user_handle_request', invite: invitation
    else
      return render 'send_invite', user: user
    end

    markup.html_safe
  end

  def display_each_user(user)
    if user == current_user
      render 'my_profile'
    else
      render 'user', user: user
    end
  end

  def single_user_action_links(user)
    request_pending = current_user.pending_requests.include?(user)
    invitation_pending = current_user.pending_invitations.include?(user)
    friends = current_user.friends.include?(user)

    if invitation_pending
      invitation = Friendship.where(user_id: user.id, friend_id: current_user.id)
      render 'user_handle_request', invite: invitation
    elsif !friends && !request_pending
      return if user == current_user

      render 'send_invite', user: user
    end
  end
end
