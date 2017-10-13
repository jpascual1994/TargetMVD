class Chat < ApplicationRecord
  belongs_to :match
  has_many :messages, dependent: :destroy

  validates :match, presence: true
  validates :match_id, uniqueness: true
end
