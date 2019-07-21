require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do


  let(:valid_password_attributes) {
    {
      password: 'abcd#1234',
      password_confirmation: 'abcd#1234'
    }
  }

  let(:invalid_password_attributes) {
    {
      password: 'abcd#1234',
      password_confirmation: ''
    }
  }

  let(:user) { create :user }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do

      it "creates a valid reset password token" do
        post :create, params: { email: user.email }

        expect(user.reset_password_token).not_to eq user.reload.reset_password_token
      end

      it "redirects to the root url" do
        post :create, params: { email: user.email }
        expect(response).to redirect_to root_url
      end
    end

    context "with invalid params" do

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {email: "abc@xyz.com" }
        expect(response).to be_successful
      end

    end
  end

  describe "GET #edit" do
   it "returns a success response" do
     user.send_password_reset_mail
     get :edit, params: {id: user.reset_password_token}

     expect(response).to be_successful
   end
  end


  describe "PUT #update" do
    context "with valid params" do

      it "changes the password" do
        post :create, params: { email: user.email }
        put :update, params: {id: user.reload.reset_password_token, user: valid_password_attributes }

        expect(user.reload.reset_password_token).to be_nil
        expect(response).to redirect_to root_url
      end

      it "expires the password after 6 hours" do
        post :create, params: { email: user.email }
        user.update_attribute(:reset_password_sent_at, (Time.zone.now-6.hours) )
        put :update, params: {id: user.reload.reset_password_token, user: valid_password_attributes }

        expect(response).to redirect_to new_password_reset_path
      end

    end

    context "with invalid params" do

      it "returns a success response (i.e. to display the 'edit' template)" do
        post :create, params: { email: user.email }
        put :update, params: {id: user.reload.reset_password_token, user: invalid_password_attributes }

        expect(response).to be_successful
      end
    end
  end

end
