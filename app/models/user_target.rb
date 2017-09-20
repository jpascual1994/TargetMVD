class UserTarget < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :title, :user, :topic, :latitude, :longitude, :area, presence: true

  DEFAULT_AREAS = [50, 100, 150, 200]
end
