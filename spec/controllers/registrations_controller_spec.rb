require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe '#new' do
    before(:each) do
      get :new
    end

    it 'responds HTTP 200' do
      expect(response).to have_http_status(200)
    end

    it 'renders sign up view' do
      expect(response).to render_template('new')
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:new_user) { userParams('name', 'mail@e', '123456', '123456', 'male') }
      let(:user) { User.last }

      before(:each) do
        post :create, params: new_user, xhr: true
      end

      it 'create user' do
        expect(user.name).to eq(new_user[:user][:name])
        expect(user.email).to eq(new_user[:user][:email])
        expect(user.gender).to eq(new_user[:user][:gender])
      end

      it 'render partial confirmation sent' do
        expect(response).to render_template('create')
      end

      it 'send confirmation mail', truncation: true do
        expect(user.confirmation_sent_at?).to be true
      end

      it 'dosen\'t confirm the user' do
        expect(user.confirmed?).to be false
      end
    end

    context 'with invalid params' do
      context 'empty fields' do
        before(:each) do
          post :create, params: userParams('', '', '', '', 'male')
        end

        it 'dosen\'t create the user' do
          expect(User.count).to eq(0)
        end

        it 'render sig up view' do
          expect(response).to render_template('new')
        end
      end

      context 'with password too short' do
        before(:each) do
          post :create, params: userParams('name', 'mail@e', '1', '1', 'male')
        end

        it 'dosen\'t create the user' do
          expect(User.count).to eq(0)
        end

        it 'render sig up view' do
          expect(response).to render_template('new')
        end
      end

      context 'with invalid password confirmation' do
        before(:each) do
          post :create, params: userParams('name', 'mail@e', '123456', 'qwerty', 'male')
        end

        it 'dosen\'t create the user' do
          expect(User.count).to eq(0)
        end

        it 'render sig up view' do
          expect(response).to render_template('new')
        end
      end

      context 'with empty email' do
        before(:each) do
          post :create, params: userParams('name', '', '123456', '123456', 'male')
        end

        it 'dosen\'t create the user' do
          expect(User.count).to eq(0)
        end

        it 'should render sig up view' do
          expect(response).to render_template('new')
        end
      end

      context 'with a email already used' do
        before(:each) do
          FactoryGirl.create( :user, email: 'mail@e' )
          post :create, params: userParams('name', 'mail@e', '123456', 'qwerty', 'male')
        end

        it 'dosen\'t create the user' do
          expect(User.count).to eq(1)
        end

        it 'should render sig up view' do
          expect(response).to render_template('new')
        end
      end
    end
  end
end

def userParams (name, email, password, password_confirmation, gender)
  {
    user: {
      name: name,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      gender: gender
    }
  }
end
