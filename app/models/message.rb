class Message < ApplicationRecord
  belongs_to :chat
  validates :chat, presence: true
end
