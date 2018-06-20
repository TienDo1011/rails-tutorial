class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :follow, :unfollow]
  before_action :correct_user, only: [:edit, :update, :follow, :unfollow]
  before_action :admin_user, only: :destroy

  def index
    @users = User.limit(User::USERS_PER_PAGE).offset(offset)
    render json: { users: @users }
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.limit(Micropost::MICROPOSTS_PER_PAGE).offset(offset)
    render json: { user: @user, microposts: @microposts }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      render json: { message: "Welcome to the Sample App!" }
    else
      render json: { message: get_error(@user) }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: { message: "Profile updated" }
    else
      render json: { message: get_error(@user) }, status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    render json: { message: "User deleted." }
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.limit(User::USERS_PER_PAGE).offset(offset)
    render json: { title: @title, current_user: @user, followings: @users }
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.limit(User::USERS_PER_PAGE).offset(offset)
    render json: { title: @title, current_user: @user, followers: @users }
  end

  def follow
    @user = User.find(params[:id])
    @user.follow!(params[:followed_user_id])
    @followed_user = User.find(params[:followed_user_id])
    render json: { message: "You have followed #{@followed_user.name}" }
  end

  def unfollow
    @user = User.find(params[:id])
    @user.unfollow!(params[:unfollowed_user_id])
    @unfollowed_user = User.find(params[:unfollowed_user_id])
    render json: { message: "You have unfollowed #{@unfollowed_user.name}" }
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      render json: { message: 'Forbidden' }, status: :forbidden unless current_user?(@user)
    end

    def admin_user
      render json: { message: 'Forbidden' }, status: :forbidden unless current_user.admin?
    end

    def offset
      User::USERS_PER_PAGE * params[:page] if params[:page] else 0
    end
end
