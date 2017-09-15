class UserTargetsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    @user_targets = current_user.user_targets
  end
end
