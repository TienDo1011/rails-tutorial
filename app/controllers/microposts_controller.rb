class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      render json: { message: "Micropost created!"}
    else
      @feed_items = []
      render json: { message: "Failed to create micropost, try again later"}, status: :unprocessable_entity
    end
  end

  def destroy
    @micropost = current_user.microposts.find(params[:id])
    @micropost.destroy
    render json: { message: "Micropost destroyed!"}
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      render json: { message: "Forbidden!"}, status: :forbidden if @micropost.nil?
    end
end