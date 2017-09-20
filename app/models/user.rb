class User < ApplicationRecord
  has_many :user_targets, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook]

  enum gender: { male: 0, female: 1, others: 2 }

  def self.from_omniauth(auth)
    where( provider: auth.provider, uid: auth.uid ).first_or_create do |user|
      facebook_gender = auth.extra.raw_info.gender
      facebook_info = auth.info
      user.email = facebook_info.email
      user.password = Devise.friendly_token[0,20]
      user.name = facebook_info.name
      user.gender = genders.key?( facebook_gender ) ? facebook_gender : 'others'
      user.skip_confirmation!
    end
  end

  def self.default_genders
    genders.map { |key,value| [ key.humanize, key ] }
  end
end
