class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    if current_user
      @q = @category.articles.readable_articles(current_user).ransack(params[:q])
    else  
      @q = @category.articles.where(authority: "all").ransack(params[:q])
    end
    @article = @q.result.includes(:comments).page(params[:page]).per(10)
  end

  def index
    @categories = Category.all
    
    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
