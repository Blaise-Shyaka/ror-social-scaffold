class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
    @requests = current_user.pending_requests
    @invitations = current_user.pending_invitations
  end

  def create
    @friendship = Friendship.new(friendship_params)
    return unless @friendship.save

    redirect_to users_path, notice: 'Friendship request sent successfully'
  end

  def accept
    @invitation = Friendship.find(params[:id])
    @invitation.update(status: true)
    @confirmed_friendship = Friendship.create!(
      user_id: @invitation.friend_id,
      friend_id: @invitation.user_id,
      status: true
    )

    redirect_to friendships_path
  end

  def reject
    @invitation = Friendship.find(params[:id])
    @invitation.destroy
    redirect_to friendships_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
