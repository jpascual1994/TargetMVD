class UsersController < ApplicationController
  before_action :authenticate_user!

  def homepage
    @user = current_user
    @topics = Topic.all
  end

  def update
    if current_user.update(user_params)
      head :ok
    else
      head :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_login)
  end
end
