class UserTarget < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :title, :user, :topic, :latitude, :longitude, :area, presence: true
  validate :target_limit

  DEFAULT_AREAS = [50, 100, 150, 200]

  private

  def target_limit
    errors.add(:base, 'Too many targets created') if user.user_targets.size > 9
  end
end
