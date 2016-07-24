require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #create" do
    let(:user) {FactoryGirl.create :user}
    it "login success with correct email and password" do
      get :create, password: user.password, email: user.email
      expect(response).to redirect_to root_path
    end
  end

  describe "GET #destroy" do
    it "logout success" do
      get :destroy
      expect(response).to render_template 'new'
    end
  end

end
