class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
    @requests = current_user.pending_requests
    @invitations = current_user.pending_invitations
  end

  def create
    @friendship = current_user.friendships.new(friendship_params)
    return unless @friendship.save

    redirect_to users_path, notice: 'Friendship request sent successfully'
  end

  def accept
    @invitation = Friendship.find(params[:id])
    @invitation.update(status: true)
    redirect_to friendships_path
  end

  def reject
    @invitation = Friendship.find(params[:id])
    @invitation.destroy
    redirect_to friendships_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:receiver_id, :status)
  end
end
