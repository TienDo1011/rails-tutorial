module AuthHelpers
  extend Grape::API::Helpers
  
  def current_user
    token = request.headers["Authorization"].split(" ")[1] if request.headers["Authorization"];
    remember_token = User.digest(token)
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end

  def check_admin!
    error!('403 Forbidden', 403) unless current_user.admin?
  end
end