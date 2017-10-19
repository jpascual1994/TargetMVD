class Message < ApplicationRecord
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'
  belongs_to :chat

  scope :to_user, ->(user_id) { where(to_id: user_id) }
  scope :unread, -> { where(read: false) }
end
