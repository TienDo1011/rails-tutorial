class Users < Grape::API
  helpers AuthHelpers

  helpers do
    def offset
      skip = if params[:page]
        params[:page] - 1
      else
        0
      end
      User::USERS_PER_PAGE * (skip)
    end
  end

  resource :users do
    desc "Get users list"
    params do
      optional :page, type: Integer
    end
    get do
      authenticate!
      users = User.limit(User::USERS_PER_PAGE).offset(offset)
      total_pages = (User.count.to_f / User::USERS_PER_PAGE).ceil
      {
        users: users,
        meta: {
          total_pages: total_pages
        }
      }
    end

    desc "Get current user's feed"
    get "feed" do
      authenticate!
      current_user.feed
    end

    desc "Get an user details"
    params do
      requires :id, type: Integer
    end
    get ':id' do
      User.find(params[:id])
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
    post do
      User.create!(params[:user])
    end

    desc "Update user profile"
    params do
      requires :id, type: Integer
      requires :name, type: String
      requires :email, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    put ":id" do
      authenticate!
      user = User.find(params[:id])
      user.update!(params)
      token = User.token
      digest_token = User.digest(token)
      user.update_attribute(:digest_token, digest_token)
      {
        token: token,
        id: user.id,
        email: user.email,
        name: user.name,
        admin: user.admin
      }
    end

    desc "Sign up"
    params do
      requires :name, type: String
      requires :email, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    post "signup" do
      user = User.create(params)
      err = user.errors.messages
			messages = []
			err.keys.map do |key|
				messages.push("#{key.to_s} #{err[key][0]}")
			end
      if messages.count > 0
        error!(messages.join(', '), 422)
      else
        token = User.token
        digest_token = User.digest(token)
        user.update_attribute(:digest_token, digest_token)
        {
          token: token,
          id: user.id,
          email: user.email,
          name: user.name,
          admin: user.admin
        }
      end
    end

    desc "Sign in"
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post "signin" do
      user = User.find_by(email: params[:email])
      if !user
        error!('User not exist', 404)
      end
      user.authenticate(params[:password])
      token = User.token
      digest_token = User.digest(token)
      user.update_attribute(:digest_token, digest_token)
      {
        token: token,
        id: user.id,
        email: user.email,
        name: user.name,
        admin: user.admin
      }
    end

    desc "Sign out"
    post "signout" do
      authenticate!
      current_user.update_attribute(:digest_token, nil)
    end

    desc "Destroy an user"
    params do
      requires :id, type: Integer
    end
    delete ":id" do
      check_admin!
      User.find(params[:id]).destroy
    end

    desc "Get an user's micropost list"
    params do
      requires :id, type: Integer
    end
    get ":id/microposts" do
      @user = User.find(params[:id])
      @user.microposts.limit(User::USERS_PER_PAGE).offset(offset)
    end

    desc "Get an user's following list"
    params do
      requires :id, type: Integer
    end
    get ":id/followings" do
      @user = User.find(params[:id])
      @user.followed_users.limit(User::USERS_PER_PAGE).offset(offset)
    end

    desc "Get an user's followers"
    params do
      requires :id, type: Integer
    end
    get ":id/followers" do
      @user = User.find(params[:id])
      @user.followers.limit(User::USERS_PER_PAGE).offset(offset)
    end

    desc "Follow an user"
    params do
      requires :id, type: Integer
    end
    post "follow" do
      authenticate!
      current_user.follow!(params[:id])
      current_user
    end

    desc "Unfollow an user"
    params do
      requires :id, type: Integer
    end
    post "unfollow" do
      authenticate!
      current_user.unfollow!(params[:id])
    end
  end
end
