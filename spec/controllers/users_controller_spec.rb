require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#homepage' do
    let!(:user) { FactoryGirl.create(:user) }

    context 'with user signed in' do
      before (:each) do
        user.confirm
        sign_in user
        get :homepage
      end

      it 'responds HTTP 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders homepage' do
        expect(response).to render_template('homepage')
      end
    end

    context 'without user signed in' do
      before (:each) do
        get :homepage
      end

      it 'responds HTTP 302, URL redirection' do
        expect(response).to have_http_status(302)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#update' do
    let!(:user) { FactoryGirl.create(:user, first_login: false) }

    before(:each) do
      user.confirm
      sign_in user
    end

    context 'update first login ' do
      before(:each) do
        patch :update, params: { user: { first_login: 'true' } }
        user.reload
      end

      it 'responds HTTP 200' do
        expect(response).to have_http_status(200)
      end

      it 'update first login' do
        expect(user.first_login).to be true
      end
    end
  end
end
