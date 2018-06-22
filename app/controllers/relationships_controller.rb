class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user.id)
    render json: {message: "You have followed #{@user.name}!"}
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user.id)
    render json: {message: "You have unfollowed #{@user.name}"}
  end
end
