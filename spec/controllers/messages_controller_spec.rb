require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe '#create' do
    context 'with valid params' do
      let(:user) { User.first }
      let(:chat) { Chat.first }

      before(:each) do
        create_user_with_match
        user.confirm
        sign_in user
        post :create, params: { message: { text: 'hola', chat_id: chat.id, user_id: user.id } }, xhr: true
      end

      it 'responds http 200' do
        expect(response).to have_http_status(200)
      end

      it 'responds with correct format' do
        expect(response.content_type).to eq 'text/javascript'
      end

      it 'creates a message' do
        expect(Message.count).to eq(1)
      end

      it 'creates a message with correct data' do
        expect(Message.last.text).to eq('hola')
      end
    end
  end
end
