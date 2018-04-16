class DraftsController < ApplicationController

  def index
    @draft = Draft.all
  end

  def new
    @draft = Draft.new
    @article = Article.new
  end

  def create
    @draft = Draft.new(draft_params)
    if @draft.save
      redirect_to drafts_path
      flash[:notice] = "draft was successfully created"
    else
      render :new
      flash[:notice] = "draft was failed to created"
    end
  end

  def show
    @draft = Draft.find(params[:id])
  end

  def edit
    @draft = Draft.find(params[:id])
    @article = Article.new
  end

  def update
    @draft = Draft.find(params[:id])
    if @draft.update(draft_params)
      redirect_to draft_path(@draft)
      flash[:notice] = "Draft was successfully updated!!"
    else
      render :edit
      flash[:notice] = "Draft was failed to update"
    end
  end

  def destroy
    @draft = Draft.find(params[:id])
    @draft.destroy
    redirect_to drafts_path
  end


  private

  def draft_params
    params.require(:draft).permit(:title, :content, :image)    
  end

  def set_draft
    @draft = Draft.find(params[:id])
  end

end
