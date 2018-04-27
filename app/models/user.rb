class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :comments, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_articles, through: :collects, source: :article

  has_many :friend_requests2s, dependent: :destroy
  has_many :pending_friends, through: :friend_requests2s, source: :friend

  has_many :friendship2s, dependent: :destroy
  has_many :friends, through: :friendship2s

  mount_uploader :avatar, AvatarUploader

  ROLE_STATUS = [
    ["Admin", :admin],
    ["Normal", :normal]
  ]

  def admin?
    self.role == "admin"
  end

  def remove_friend(friend)
    friends.destroy(friend)
  end

end
