class CommentsController < ApplicationController
   before_action :set_article, only: [:create, :edit, :update, :destroy]
   before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to article_path(@article)
  end

  def edit
  end
  
  def update
    if @comment.update(comment_params)
      redirect_to article_path(@article)
      flash[:notice] = "comment was successfully updated"
    else
      redirect_to article_path(@article)
    end
  end


  def destroy
    @comment.destroy
    redirect_to article_path(@article)
  end

  private 

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end 

  def comment_params
    params.require(:comment).permit(:content)
  end

end
