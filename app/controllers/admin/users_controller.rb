class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User Role Updated"
    else
      flash.now[:alert] = @order.errors.full_messages.to_sentence
      render "admin/users/edit"  
    end
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not Allow"
      redirect_to root_path
    end
  end

end
