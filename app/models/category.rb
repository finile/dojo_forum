class Category < ApplicationRecord

  # has_many :article_categories
  # has_many :articles, through: :article_categories
  has_and_belongs_to_many :articles, dependent: :destroy


end
