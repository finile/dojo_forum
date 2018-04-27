class Api::V1::ArticlesController < ApiController
  before_action :authenticate_user!, except: :index
  before_action :set_article, only:[:show, :edit, :update, :destroy]

  def index
    @article = Article.all
  end

  def show
    if !@article
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    else
      render "api/v1/articles/show"
    end    
  end

  def create  
    @article = Article.new(article_params)
        
    if @article.save
      render json: {
        message: "成功新增文章",
        result: @article
      }
    else
      render json: {
        errors: @article.errors
      }
    end
  end

  def update
    if @article.update(article_params)
      render json: {
        message: "成功更新文章",
        result: @article
      }
    else
      render json: {
        errors: @article.errors
      }
    end
  end

  def destroy
    @article.destroy
    render json: {
      message: "成功刪除文章"
    }
  end  


  private

  def article_params
    params.permit(:title, :content, :image, :authority, :published_at, category_ids:[])    
  end


  def set_article
    @article = Article.find_by(id: params[:id])
  end

end
