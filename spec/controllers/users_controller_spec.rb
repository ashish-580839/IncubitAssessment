require 'rails_helper'

RSpec.describe UsersController, type: :controller do


  let(:valid_attributes) {
    # skip("Add a hash of attributes valid for your model")
    {
      name: 'ashish',
      email: 'ashish@example.com',
      password: '12345678',
      password_confirmation: '12345678'
    }
  }

  let(:invalid_attributes) {
    {
      name: 'ashish',
      email: 'ashish@example.com',
      password: '12345678',
      password_confirmation: '1'
    }
  }


  let(:valid_edit_attributes) {
    {
      name: 'ashish agarwal',
      username: 'ashish1'
    }
  }

  let(:invalid_edit_attributes) {
    {
      name: 'ashish agarwal',
      username: 'ash'
    }
  }

  let(:user) { create :user }

  let(:valid_session) { {auth_token: user.auth_token} }


  describe "POST #create" do
    context "with valid params" do

      let!(:valid_session) { {auth_token: user.auth_token} }
      let!(:users_count_was) {  User.count }

      it "creates a new User" do
        post :create, params: {user: valid_attributes}

        expect(User.all.count).to eq (users_count_was + 1)
      end

      it "redirects to the created user" do
        post :create, params: {user: valid_attributes}
        expect(response).to redirect_to user_url(assigns(:user))
      end
    end

    context "with invalid params" do

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {user: invalid_attributes}
        expect(response).to be_successful
      end

    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :show, params: {id: user.id}, session: {auth_token: user.auth_token}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
   it "returns a success response" do
     user = User.create! valid_attributes
     get :edit, params: {id: user.id}, session: {auth_token: user.auth_token}
     expect(response).to be_successful
   end
 end


  describe "PUT #update" do
    context "with valid params" do
      let!(:user) { create :user }

      it "updates the requested user" do
        put :update, params: {id: user.id, user: valid_edit_attributes }, session: valid_session
        user.reload
        expect(user.name).to eq valid_edit_attributes[:name]
        expect(response).to redirect_to user_url(assigns(:user))
      end
    end

    context "with invalid params" do

      it "returns a success response (i.e. to display the 'edit' template)" do
        user = User.create! valid_attributes
        put :update, params: {id: user.id, user: invalid_edit_attributes }, session: {auth_token: user.auth_token}
        expect(response).to be_successful
      end
    end
  end


end
