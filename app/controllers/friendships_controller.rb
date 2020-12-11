class FriendshipsController < ApplicationController
  def index
    @requests = current_user.friendships.all
    @invitations = current_user.invitations.all
  end
end