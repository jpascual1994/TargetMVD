class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook]

  enum gender: { male: 0, female: 1, others: 2 }

  def self.from_omniauth(auth)
    where( provider: auth.provider, uid: auth.uid ).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.gender = genders.key?( auth.extra.raw_info.gender ) ? auth.extra.raw_info.gender : 'others'
      user.skip_confirmation!
    end
  end
end
