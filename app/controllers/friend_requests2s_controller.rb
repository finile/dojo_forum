class FriendRequests2sController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]

  def index
    @received = FriendRequests2.where(friend: current_user)
    @sent = current_user.friend_requests2s
  end

  def new
    
  end

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests2s.build(friend: friend)

    if @friend_request.save
      flash[:success] = 'Friend request sent.'
    else
      flash[:danger] = 'Friend request could not be sent.'
    end
    redirect_to request.referrer
  end

  def update
    @friend_request.accept_friend
    flash[:success] = 'Friend request accepted.'
    redirect_to request.referrer
  end
  
  def destroy
    @friend_request.destroy
    flash[:info] = 'Friend request declined.'
    redirect_to request.referrer
  end

  private

  def set_friend_request
    @friend_request = FriendRequests2.find(params[:id])
  end

end
