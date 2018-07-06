# Todo: Should support both put & patch

class Users < Grape::API
  helpers AuthHelpers

  helpers do
    def offset
      User::USERS_PER_PAGE * params[:page]
    end
  end

  resource :users do
    desc "Get users list"
    params do
      requires :page, type: Integer
    end
    get '/' do
      authenticate!
      User.limit(User::USERS_PER_PAGE).offset(offset)
    end

    desc "Get an user details"
    params do
      requires :id, type: String
    end
    get ':id' do
      @user = User.find(params[:id])
      @microposts = @user.microposts.limit(Micropost::MICROPOSTS_PER_PAGE).offset(offset)
      { user: @user, microposts: @microposts }
    end

    desc "Create an user"
    params do
      requires :user, type: Hash do
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
      end
    end
    post "/" do
      User.create!(params[:user])
    end

    desc "Update current user's profile"
    params do
      requires :user, type: Hash do
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
      end
    end
    # ====> Support put & patch here
    patch "/:id" do
      authenticate!
      current_user.update_attributes(params[:user])
    end

    desc "Destroy an user"
    params do
      requires :id, type: String
    end
    delete "/:id" do
      check_admin!
      User.find(params[:id]).destroy
    end

    desc "Get an user's following list"
    params do
      requires :id, type: String
    end
    get "/:id/following" do
      @user = User.find(params[:id])
      @users = @user.followed_users.limit(User::USERS_PER_PAGE).offset(offset)
      { user: @user, followings: @users }  
    end
    
    desc "Get an user's followers"
    params do
      requires :id, type: String
    end
    get "/:id/followers" do
      @user = User.find(params[:id])
      @users = @user.followers.limit(User::USERS_PER_PAGE).offset(offset)
      { user: @user, followers: @users }
    end

    desc "Follow an user"
    params do
      requires :id, type: String
    end
    post "/follow" do
      authenticate!
      current_user.follow!(params[:id])
    end

    desc "Unfollow an user"
    params do
      requires :id, type: String
    end
    post "/unfollow" do
      authenticate!
      current_user.unfollow!(params[:id])
    end
  end
end
