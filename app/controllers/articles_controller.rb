class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_article, only:[:show, :edit, :update, :destory, :collect, :uncollect]
  impressionist :actions=>[:show,:index]

  def index
    if current_user
      @q = Article.readable_articles(current_user).ransack(params[:q])
    else
      @q = Article.where(authority: "all").ransack(params[:q])
    end
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
      impressionist(@article)
    end
    
    if params[:comment_id]
      @comment = Comment.find(params[:comment_id])
    else
      @comment = Comment.new
    end
  end


  def edit
  end

  def update
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


  def destroy
    @article.destroy
    redirect_to articles_path
  end  

  def collect
    @article.collects.create!(user: current_user)
    # redirect_back(fallback_location: root_path)
    respond_to do |format|
      format.js
    end
  end

  def uncollect
    collects = Collect.where(article: @article, user: current_user)
    collects.destroy_all
    # redirect_back(fallback_location: root_path)
    respond_to do |format|
      format.js
    end
  end

  def feeds
    @users = User.all
    @articles = Article.all
    @comment = Comment.all
    @user = User.all.order(comments_count: :desc).limit(10)
    @article = Article.all.order(collects_count: :desc).limit(10)
  end


  private

  def article_params
    params.require(:article).permit(:title, :content, :image, :published_at, :authority, category_ids:[])    
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
