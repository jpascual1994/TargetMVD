require 'rails_helper'

RSpec.describe UserTargetsController, type: :controller do
  render_views

  describe 'GET #index' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:topic) { FactoryGirl.create(:topic) }
    let!(:target) { FactoryGirl.create(:user_target, user: user, topic: topic) }

    before(:each) do
      user.confirm
    end

    context 'with user signed in' do
      before(:each) do
        sign_in user
        get :index, format: :json
      end

      it 'responds HTTP 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders index' do
          expect(response).to render_template('index')
      end

      it 'responds with correct format' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'responds with correct data' do
        expect(JSON.parse(response.body)['user_targets']).to eq([
          {
            'id'=>target.id,
            'lat'=>target.latitude,
            'lng'=>target.longitude,
            'radius'=>target.area,
            'icon'=> ActionController::Base.helpers.image_path('Art.png')
          }
        ])
      end
    end

    context 'without user signed in' do
      before(:each) do
        get :index, format: :json
      end

      it 'responds HTTP 401' do
        expect(response).to have_http_status(401)
      end

      it 'responds with correct format' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'responds with correct data' do
        expect(JSON.parse(response.body)['user_targets']).to eq(nil)
      end
    end
  end
end
