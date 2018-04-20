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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end


end
