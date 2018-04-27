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

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
      flash[:notice] = "category was successfully updated"
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:alert] = "category was successfully deleted"
    redirect_to categories_path
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

end
