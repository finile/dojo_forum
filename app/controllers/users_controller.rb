class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]


  def show
    @user = User.find(params[:id])
    @posted_articles = @user.articles
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def posted_articles
    @user = User.find(params[:id])
    @posted_articles = @user.articles
  end

  def posted_drafts
    @user = User.find(params[:id])
    @posted_articles = @user.articles
  end

  def posted_comments
    @user = User.find(params[:id])
    @posted_comments = @user.comments
  end

  def collected_articles
    @user = User.find(params[:id])
    @collected_articles = @user.collected_articles
  end

  def friends
    @user = User.find( params[:id])
    @received = FriendRequests2.where(friend: current_user)
    @sent = current_user.friend_requests2s
    @friends = @user.friends
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end


end
