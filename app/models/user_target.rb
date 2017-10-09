class UserTarget < ApplicationRecord
  acts_as_mappable default_units: :meters,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude
  belongs_to :user
  belongs_to :topic
  has_many :matches_as_first, foreign_key: 'first_target_id', class_name: 'Match', dependent: :destroy
  has_many :matches_as_second, foreign_key: 'second_target_id', class_name: 'Match', dependent: :destroy

  validates :title, :user, :topic, :latitude, :longitude, :area, presence: true
  validate :target_limit

  scope :not_from_user, ->(user_id) { where.not(user_id: user_id) }
  scope :with_topic, ->(topic_id) { where(topic_id: topic_id) }

  DEFAULT_AREAS = [50, 100, 150, 200]

  def matches
    matches_as_first | matches_as_second
  end

  private

  def target_limit
    errors.add(:base, 'Too many targets created') if user.user_targets.size > 9
  end
end
