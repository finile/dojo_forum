class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :article


end
