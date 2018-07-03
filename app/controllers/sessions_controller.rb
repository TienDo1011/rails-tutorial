class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      render json: { user: user }
    else
      render json: { message: get_error(user) }, status: :unauthorized
    end
  end

  def destroy
    sign_out
    render json: { message: 'Sign out successful' }
  end
end