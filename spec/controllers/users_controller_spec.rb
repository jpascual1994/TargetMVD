require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "#homepage" do
    let!(:user) { FactoryGirl.create( :user ) }

    context "with user signed in" do
      before (:each) do
        user.confirm
        sign_in user
        get :homepage
      end

      it "responds HTTP 200" do
        expect(response).to have_http_status( 200 )
      end

      it "renders " do
        expect(response).to render_template( "homepage" )
      end
    end

    context "without user signed in" do
      before (:each) do
        get :homepage
      end

      it "responds HTTP 302, URL redirection" do
        expect(response).to have_http_status( 302 )
      end

      it "redirect to sign in page " do
        expect(response).to redirect_to( new_user_session_path )
      end
    end
  end
end
