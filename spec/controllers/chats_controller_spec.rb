require 'rails_helper'

RSpec.describe ChatsController, type: :controller do
  describe "#show" do
    let(:user) { User.first }
    let(:chat) { Chat.first }
    before(:each) do
      create_user_with_match
      user.confirm
      sign_in user
      get :show, params: { id: chat.id }, xhr: true
    end

    it 'responds HTTP 200' do
      expect(response).to have_http_status(200)
    end

    it 'renders confirmation view' do
      expect(response).to render_template('show')
    end

    it 'responds with correct format' do
      expect(response.content_type).to eq 'text/javascript'
    end
  end
end
