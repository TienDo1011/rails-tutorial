class Relationships < Grape::API
  helpers AuthHelpers

  resource :relationships do
    desc "Create a relationship"
    params do
      requires :relationship, type: Hash do
        requires :followed_id, type: String
      end
    end
    post do
      authenticate!
      @user = User.find(params[:relationship][:followed_id])
      current_user.follow!(@user.id)
    end

    desc "Delete a relationship"
    params do
      requires :id, type: String
    end
    delete ":id" do
      authenticate!
      @user = Relationship.find(params[:id]).followed
      current_user.unfollow!(@user.id)
    end
  end
end