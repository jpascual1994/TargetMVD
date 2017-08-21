require "rails_helper"

RSpec.describe HomeController, :type => :controller do
  describe "GET #index" do
    before(:each) do
      get :index
    end

    it "responds HTTP 200" do
      expect(response).to have_http_status(200)
    end

    it "renders index" do
      expect(response).to render_template( "index" )
    end
  end
end