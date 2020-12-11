class FriendshipsController < ApplicationController
  def index
    @requests = current_user.friendships.all
    @invitations = current_user.invitations.all
  end
  
  def create
    @friendship = current_user.friendships.new(friendship_params)
    if @friendship.save
      redirect_to users_path, notice: "Friendship request sent successfully"
    end
  end

  def accept
    @invitation = Friendship.find(params[:id])
    @invitation.update(status: true)
    redirect_to friendships_path
  end

  def reject
    @invitation = Friendship.find(params[:id])
    @invitation.update(status: false)
    redirect_to friendships_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:receiver_id, :status)
  end
end