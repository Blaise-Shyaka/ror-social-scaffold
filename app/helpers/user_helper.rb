module UserHelper
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
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
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def display_each_user(user)
    if user == current_user
      render 'my_profile'
    else
      render 'user', user: user
    end
  end

  def single_user_action_links(user)
    invite = current_user.invitations.where(sender_id: params[:id])
    friendship = current_user.friendships.where(receiver_id: params[:id])
    if invite.any?
      return if invite[0].status

      render 'user_handle_request', invite: invite
    elsif friendship.none?
      return if user == current_user

      render 'send_invite', user: user
    end
  end
end
