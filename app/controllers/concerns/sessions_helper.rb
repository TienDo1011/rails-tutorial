module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    token = request.headers["Authorization"].split(" ")[1] if request.headers["Authorization"];
    remember_token = User.digest(token)
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
    self.current_user = nil
  end

  def signed_in_user
    render json: { message: "Not authenticated" }, status: :unauthorized unless signed_in?
  end
end
