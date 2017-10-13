class Match < ApplicationRecord
  belongs_to :first_target, class_name: 'UserTarget'
  belongs_to :second_target, class_name: 'UserTarget'
  has_many :user_matches, dependent: :destroy
  has_one :chat, dependent: :destroy

  before_save :build_chat

  def other_user_target(user)
    first_target.user == user ? second_target : first_target
  end
end
