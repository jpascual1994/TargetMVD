class Match < ApplicationRecord
  belongs_to :first_target, class_name: 'UserTarget'
  belongs_to :second_target, class_name: 'UserTarget'

  has_many :user_matches, dependent: :destroy
end
