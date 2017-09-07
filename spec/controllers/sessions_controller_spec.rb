require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      user.confirm
      sign_in user
      delete :destroy
    end

    it 'should log out the user' do
      expect(subject.current_user).to be nil
    end
  end
end
