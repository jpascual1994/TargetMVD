class HomeController < ApplicationController
  layout 'home'

  def index
    redirect_to homepage_users_path if user_signed_in?
  end
end
