class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :posted_articles, :posted_drafts, :posted_comments, :collected_articles, :friends]

  def show
    @posted_articles = @user.articles
  end

  def edit
    unless @user == current_user
      redirect_to posted_articles_user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to posted_articles_user_path(@user)
  end

  def posted_articles
    @posted_articles = @user.articles
  end

  def posted_drafts
    @posted_articles = @user.articles
  end

  def posted_comments
    @posted_comments = @user.comments.page(params[:page]).per(5)
  end

  def collected_articles
    @collected_articles = @user.collected_articles
  end

  def friends
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
