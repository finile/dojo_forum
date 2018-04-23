class Friendship2sController < ApplicationController
  before_action :set_friend, only: :destroy

  def destroy
    current_user.remove_friend(@friend)
    flash[:info] = 'Friend removed.'
    redirect_to request.referrer
  end

  private

  def set_friend
    @friend = User.find(params[:id])
  end
  
end
