class Article < ApplicationRecord

  belongs_to :user
  has_many :comments

  def published?
    published_at?
  end

end
