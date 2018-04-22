class Article < ApplicationRecord

  belongs_to :user
  has_many :comments
  # has_many :article_categories
  # has_many :categories, through: :article_categories
  has_and_belongs_to_many :categories

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  def published?
    published_at?
  end

  def is_collected?(user)
    self.collected_users.include?(user)
  end

end
