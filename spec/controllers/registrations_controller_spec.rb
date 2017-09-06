require "rails_helper"

RSpec.describe Users::RegistrationsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#new" do
    before(:each) do
      get :new
    end

    it "responds HTTP 200" do
      expect(response).to have_http_status( 200 )
    end

    it "renders sign up view" do
      expect(response).to render_template( "new" )
    end
  end

  describe "#create" do
    context "with valid params" do
      let(:user_params) { { name: "name", email: "mail@e", password: "123456", password_confirmation: "123456", gender: "male" } }
      let(:user) { User.last }

      before(:each) do
        xhr :post, :create, user: user_params
      end

      it "create user" do
        expect(user.name).to eq(user_params[ :name ])
        expect(user.email).to eq(user_params[ :email ])
        expect(user.gender).to eq(user_params[ :gender ])
      end

      it "render partial confirmation sent" do
        expect(response).to render_template( 'create' )
      end

      it "send confirmation mail", truncation: true do
        expect(user.confirmation_sent_at?).to be true
      end

      it "not confirm the user" do
        expect(user.confirmed?).to be false
      end
    end

    context "with invalid params" do
      context "empty fields" do
        before(:each) do
          post :create, user: { name: "", email: "", password: "", password_confirmation: "", gender: "male" }
        end

        it "shouldn't create the user" do
          expect(User.count).to eq(0)
        end

        it "should render sig up view" do
          expect(response).to render_template( "new" )
        end
      end

      context "with password too short" do
        before(:each) do
          post :create, user: { name: "name", email: "mail@e", password: "1", password_confirmation: "1", gender: "male" }
        end

        it "shouldn't create the user" do
          expect(User.count).to eq(0)
        end

        it "should render sig up view" do
          expect(response).to render_template( "new" )
        end
      end

      context "with invalid password confirmation" do
        before(:each) do
          post :create, user: { name: "name", email: "mail@e", password: "123456", password_confirmation: "qwerty", gender: "male" }
        end

        it "shouldn't create the user" do
          expect(User.count).to eq(0)
        end

        it "should render sig up view" do
          expect(response).to render_template( "new" )
        end
      end

      context "with empty email" do
        before(:each) do
          post :create, user: { name: "name", email: "", password: "123456", password_confirmation: "123456", gender: "male" }
        end

        it "shouldn't create the user" do
          expect(User.count).to eq(0)
        end

        it "should render sig up view" do
          expect(response).to render_template( "new" )
        end
      end

      context "with a email already used" do
        before(:each) do
          FactoryGirl.create( :user, email: "mail@e" )
          post :create, user: { name: "name", email: "mail@e", password: "123456", password_confirmation: "qwerty", gender: "male" }
        end

        it "shouldn't create the user" do
          expect(User.count).to eq(1)
        end

        it "should render sig up view" do
          expect(response).to render_template( "new" )
        end
      end
    end
  end
end
