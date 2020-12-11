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

  private

  def friendship_params
    params.require(:friendship).permit(:receiver_id, :status)
  end
end