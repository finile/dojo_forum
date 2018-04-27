class Article < ApplicationRecord
  validates_presence_of :title, :content

  belongs_to :user

  has_many :comments
    
  # has_many :article_categories
  # has_many :categories, through: :article_categories
  has_and_belongs_to_many :categories

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  mount_uploader :image, ImageUploader

  def published?
    published_at?
  end

  def is_collected?(user)
    self.collected_users.include?(user)
  end

  def self.readable_articles(user)
    Article.where(authority: "friend", user: user.friends).or( where(authority: "all")).or(where(authority: "myself", user: user)).or(where( user: user))
  end

  def check_authority_for?(user)
    Article.readable_articles(user).include?(self)
  end

  is_impressionable :counter_cache => true, :column_name => :views_count
  
end
