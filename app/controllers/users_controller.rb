class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
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
      render json: { message: "Error creating user, try again" }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update_attributes(user_params)
      render json: { message: "Profile updated" }
    else
      render json: { message: "Error creating user, try again" }, status: :unprocessable_entity
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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def offset
      User::USERS_PER_PAGE * params[:page] if params[:page] else 0
    end
end
