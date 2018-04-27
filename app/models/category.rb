class Category < ApplicationRecord
  validates_presence_of :name
  # has_many :article_categories
  # has_many :articles, through: :article_categories
  has_and_belongs_to_many :articles, dependent: :destroy

end
