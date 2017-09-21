class UserDecorator < Draper::Decorator
  delegate_all

  def self.default_genders
    genders.map { |key,value| [ key.humanize, key ] }
  end
end
