require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe 'GET #facebook' do
    before(:each) do
      set_request_env_for_omniauth
    end

    context 'valid sign in' do
      before(:each) do
        get :facebook
      end

      it 'responds HTTP 302' do
        expect(response).to have_http_status( 302 )
      end

      it 'redirect to home page' do
        expect(response).to redirect_to( homepage_users_path )
      end

      it 'should sign in user' do
        expect(subject.current_user.present?).to be true
      end

      it 'create new user with correct data' do
        expect(User.count).to eq(1)
        u = User.last
        expect(u.email).to eq('mail@email.com')
        expect(u.gender).to eq('male')
      end
    end

    context 'facebook email already exist in the system' do
      let!(:user) { FactoryGirl.create( :user, email: 'mail@email.com' ) }

      before(:each) do
        get :facebook
      end

      it 'responds HTTP 302' do
        expect(response).to have_http_status( 302 )
      end

      it 'redirect to home page' do
        expect(response).to redirect_to( new_user_registration_path )
      end

      it 'shoulnd\'t sign in user' do
        expect(subject.current_user.present?).to be false
      end
    end
  end
end

