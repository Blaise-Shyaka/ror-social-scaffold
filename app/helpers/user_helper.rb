module UserHelper
  def display_send_invite_form
    "<%= form_for @friendship, url: friendships_path, method: :post do |f| %>
      <%= f.hidden_field :receiver_id, value: user.id %>
      <%= f.hidden_field :status, value: nil %>
      <%= f.submit 'Send Invite' %>
    <% end %>"
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def display_status_or_call_to_action_links(user)
    invite = current_user.invitations.where(sender_id: user.id)
    friendship = current_user.friendships.where(receiver_id: user.id)
    markup = ''
    if invite.any?
      if invite[0].status
        markup << 'You are friends'
      elsif invite[0].status.nil?
        return render 'user_handle_request', invite: invite
      end
    elsif friendship.any?
      markup << 'You are friends' if friendship[0].status
    elsif friendship.none?
      return render 'send_invite', user: user
    end
    markup.html_safe
  end
  # rubocop:enable Metrics/CyclomaticComplexity

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
      render 'send_invite', user: user
    end
  end
end
