class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :comments, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_articles, through: :collects, source: :article



  def admin?
    self.role == "admin"
  end

  ROLE_STATUS = [
    ["Admin", :admin],
    ["Normal", :normal]
  ]


end
