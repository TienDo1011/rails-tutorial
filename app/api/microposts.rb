class Microposts < Grape::API
  helpers AuthHelpers
  
  resource :microposts do
    desc "Create a micropost"
    params do
      requires :micropost, type: Hash do
        requires :content, type: String
      end
    end
    post '/' do
      authenticate!
      Micropost.create!({
        user: current_user,
        content: params[:micropost][:content]
      })
    end

    desc "Delete a micropost"
    params do
      requires :id, type: String
    end
    delete ":id" do
      authenticate!
      current_user.microposts.find(params[:id]).destroy
    end
  end
end