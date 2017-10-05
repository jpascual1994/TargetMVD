class UserMatch < ApplicationRecord
  belongs_to :user
  belongs_to :match, dependent: :destroy
end
