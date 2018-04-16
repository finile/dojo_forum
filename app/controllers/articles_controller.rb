class ArticlesController < ApplicationController
  def index
    @article = Article.all
  end

  def new
    if current_user.nil?
      redirect_to new_user_session_path
    else    
      @article = Article.new
    end
  end

  def create  
      @article = current_user.articles.new(article_params)
      @article.published_at = Time.zone.now if published?
    
      if @article.save
        redirect_to articles_path, notice: "new article created"
      else
        redirect_to root_path
        flash[:notice] = "draft was failed to created"
      end
  end

  def show
    if current_user.nil?
      redirect_to new_user_session_path
    else
      @article = Article.find(params[:id])
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.published_at = Time.zone.now if published?

    if @article.update(article_params)
      redirect_to article_path(@article)
      flash[:notice] = "Article was successfully updated!!"
    else
      render :edit
      flash[:notice] = "Article was failed to update"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end  

  private

  def article_params
    params.require(:article).permit(:title, :content, :image)    
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def published?
    params[:commit] == "submit"
  end

  def save_as_draft?
    params[:commit] == "save"
  end

end
