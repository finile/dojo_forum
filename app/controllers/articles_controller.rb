class ArticlesController < ApplicationController

  impressionist :actions=>[:show,:index]
  helper_method :sort_column, :sort_direction

  def index
    @q = Article.ransack(params[:q])
    @article = @q.result.includes(:comments).page(params[:page]).per(10)
    @categories = Category.all
  end

  def new
    if current_user.nil?
      redirect_to new_user_session_path
    else    
      @article = Article.new
    end
  end

  def create  
    @article = current_user.articles.build(article_params)
    @article.published_at = Time.zone.now if published?
        
    if @article.save && published?
      redirect_to article_path(@article), notice: "new article created"
    elsif @article.save != published?
      redirect_to posted_drafts_user_path(current_user), notice: "new draft created"
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
      impressionist(@article)
    end
    
    if params[:comment_id]
      @comment = Comment.find(params[:comment_id])
    else
      @comment = Comment.new
    end
    
  end


  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.published_at = Time.zone.now if published?

    if @article.update(article_params) && published?
      redirect_to article_path(@article)
      flash[:notice] = "Article was successfully updated!!"
    elsif @article.update(article_params) != published?
      redirect_to posted_drafts_user_path(current_user), notice: "Draft was sucessfully updated"
    else
      render :edit
      flash[:notice] = "Draft/Article was failed to update"
    end
  end


  def feeds
    @users = User.all
    @articles = Article.all
    @comment = Comment.all
    @user = User.all.order(comments_count: :desc).limit(10)
    @article = Article.all.order(collects_count: :desc).limit(10)
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end  


  def collect
    @article = Article.find(params[:id])
    @article.collects.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def uncollect
    @article = Article.find(params[:id])
    collects = Collect.where(article: @article, user: current_user)
    collects.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :image, :published_at, category_ids:[])    
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def published?
    params[:commit] == "Submit"
  end

  def save_as_draft?
    params[:commit] == "Save Draft"
  end

end
