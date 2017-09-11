class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  layout false

  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in @user
      redirect_to homepage_users_path
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to root_path
  end
end
