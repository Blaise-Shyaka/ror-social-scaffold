class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friendships.all
    @invitations = current_user.invitations.all
  end
end