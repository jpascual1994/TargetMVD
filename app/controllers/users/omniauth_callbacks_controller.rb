class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    request_params = request.env['omniauth.auth']
    @user = User.from_omniauth(request_params)

    if @user.persisted?
      sign_in @user
      redirect_to homepage_users_path
    else
      session['devise.facebook_data'] = request_params
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to root_path
  end
end
