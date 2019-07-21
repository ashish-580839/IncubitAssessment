require 'rails_helper'

RSpec.describe SessionsController, type: :controller do


  let(:user) { create :user }


  it "should login" do
    post :create, params: {email: user.email, password: user.password }

    expect(response).to redirect_to user_url(user)
    expect(session[:auth_token]).to eq user.auth_token
  end

  it "should fail login" do
    post :create, params: { email: user.email, password: 'wrong' }
    expect(response).to render_template(:new)
  end

  it "should logout" do
    delete :destroy
    expect(response).to redirect_to root_url
  end

end
