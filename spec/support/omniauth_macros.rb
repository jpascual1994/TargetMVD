module OmniauthMacros
  def set_valid_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock( :facebook, valid_response )
  end

  def set_invalid_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end

  def set_request_env_for_omniauth
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth::AuthHash.new(valid_response)
  end

  def valid_response
    {
      credentials: {
          expires: 'true',
          expires_at: '15',
          token: 'token'
      },
      extra: {
        raw_info: {
          email: 'mail@email.com',
          first_name: 'name',
          gender: 'male',
          id: '1234',
          last_name: 'l_name',
          name: 'name l_name'
        }
      },
      info: {
        email: 'mail@email.com',
        first_name: 'name',
        image: '',
        last_name: 'l_name',
        name: 'name l_name'
      },
      provider: 'facebook',
      uid: '1234'
    }
  end
end
