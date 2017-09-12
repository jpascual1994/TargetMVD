require "rails_helper"

RSpec.describe Users::ConfirmationsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#show" do
    let!(:user) { FactoryGirl.create( :user ) }

    context "with valid token" do
      before(:each) do
        get :show, params: { confirmation_token: user.confirmation_token }
      end

      it "responds HTTP 200" do
        expect(response).to have_http_status( 200 )
      end

      it "renders confirmation view" do
        expect(response).to render_template( "show" )
      end

      it "confirm user" do
        user.reload
        expect(user.confirmed?).to be true
      end
    end

    context "with invalid token" do
      before(:each) do
        get :show, params: { confirmation_token: '' }
      end

      it "responds HTTP 200" do
        expect(response).to have_http_status( 200 )
      end

      it "renders confirmation new" do
        expect(response).to render_template( "new" )
      end

      it "doesn\'t confirm user" do
        user.reload
        expect(user.confirmed?).to be false
      end
    end
  end
end
