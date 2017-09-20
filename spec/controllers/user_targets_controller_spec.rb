require 'rails_helper'

RSpec.describe UserTargetsController, type: :controller do
  render_views

  let!(:user) { FactoryGirl.create(:user) }
  let!(:topic) { FactoryGirl.create(:topic) }

  before(:each) do
    user.confirm
  end

  describe 'GET #index' do
    let!(:target) { FactoryGirl.create(:user_target, user: user, topic: topic, latitude: 0, longitude: 0) }

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

  describe '#create' do
    before(:each) do
      sign_in user
    end

    context 'with valid params' do
      let(:new_target) { target_params('title', 50, topic.id, 0, 0) }
      let(:target) { UserTarget.last }

      before(:each) do
        post :create, params: new_target, xhr: true
      end

      it 'responds HTTP 200' do
        expect(response).to have_http_status(200)
      end

      it 'render create view' do
        expect(response).to render_template('create')
      end

      it 'create a target with correct title' do
        expect(target.title).to eq(new_target[:user_target][:title])
      end

      it 'create a target with correct latitude' do
        expect(target.latitude).to eq(new_target[:user_target][:latitude])
      end

      it 'create a target with correct longitude' do
        expect(target.longitude).to eq(new_target[:user_target][:longitude])
      end

      it 'create a target with correct area' do
        expect(target.area).to eq(new_target[:user_target][:area])
      end
    end

    context 'with invalid params' do
      context 'empty title' do
        before(:each) do
          post :create, params: target_params('', 50, topic.id, 0, 0)
        end

        it 'responds HTTP 400' do
          expect(response).to have_http_status(400)
        end

        it 'responds with empty title error' do
          expect(response.body).to include('Title can\'t be blank')
        end
      end

      context 'empty radius' do
        before(:each) do
          post :create, params: target_params('title', '', topic.id, 0, 0)
        end

        it 'responds HTTP 400' do
          expect(response).to have_http_status(400)
        end

        it 'responds with empty area error' do
          expect(response.body).to include('Area can\'t be blank')
        end
      end

      context 'empty topic' do
        before(:each) do
          post :create, params: target_params('title', 50, '', 0, 0)
        end

        it 'responds HTTP 400' do
          expect(response).to have_http_status(400)
        end

        it 'responds with empty topic error' do
          expect(response.body).to include('Topic can\'t be blank')
        end
      end
    end
  end
end

def target_params (title, radius, topic_id, latitude, longitude)
  {
    user_target: {
      area: radius,
      title: title,
      latitude: latitude,
      longitude: longitude,
      topic_id: topic_id
    }
  }
end
