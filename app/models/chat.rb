class Chat < ApplicationRecord
  belongs_to :match
  has_many :messages, dependent: :destroy
end
