class Chat < ApplicationRecord
  belongs_to :match
  has_many :messages, dependent: :destroy

  validates :match, presence: true
  validates :match_id, uniqueness: true

  def read_messages(user_id)
    unread_messages(user_id).update_all(read: true)
  end

  def unread_messages_count(user_id)
    unread_messages(user_id).count
  end

  def unread_messages(user_id)
    messages.to_user(user_id).unread
  end
end
