class Article < ApplicationRecord

  # def submit(current_draft)
  #   @article.new
  #   @article.title = current_draft.title
  #   @article.content = current_draft.content
  #   @article.imag = current_draft.image
  # end

  belongs_to :user

  def published?
    published_at?
  end

end
