class Friendship2 < ApplicationRecord
  after_destroy :destroy_inverse_relationship

  belongs_to :user
  belongs_to :friend, :class_name => 'User'

 
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  validate :not_self

  private

  def create_inverse_relationship
    friend.friendship2s.create(friend: user)
  end

  def destroy_inverse_relationship
    friendship2 = friend.friendship2s.find_by(friend: user)
    friendship2.destroy if friendship2
  end

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end
end
