class Article < ApplicationRecord

  belongs_to :user
  has_many :comments
  # has_many :article_categories
  # has_many :categories, through: :article_categories
  has_and_belongs_to_many :categories

  def published?
    published_at?
  end

end
