class UsersController < ApplicationController
  def homepage
    if user_signed_in?
     @user = current_user
    else
     redirect_to root_path, notice: 'You are not logged in.'
   end
  end
end
