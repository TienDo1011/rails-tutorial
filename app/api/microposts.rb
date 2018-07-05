module Twitter
  class Micropost < Grape::API
    helpers do
      def current_user
        token = request.headers["Authorization"].split(" ")[1] if request.headers["Authorization"];
        remember_token = User.digest(token)
        @current_user ||= User.find_by(remember_token: remember_token)
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    resource :microposts do
      desc "creates micropost"
      params do
        requires :micropost, type: Hash do
          requires :content, type: String
        end
      end
      post '/' do
        authenticate!
        @micropost = current_user.microposts.build(params[:micropost])
        @micropost.save
      end
    end
  end
end