class UsersController < ApplicationController
  before_action :authenticate_user!

  def homepage
    @user = current_user
    @topics = Topic.all
  end
end
