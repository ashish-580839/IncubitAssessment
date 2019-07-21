require 'rails_helper'

RSpec.describe User, type: :model do

  before(:all) do
    @user1 = create(:user)
  end

  describe 'validations' do

    it "is valid with valid attributes" do
      expect(@user1).to be_valid
    end

    it "is not valid without an email" do
      user2 = build(:user, email: nil)
      expect(user2).to_not be_valid
    end

    it "is not valid with improper email" do
      user2 = build(:user, email: "person example.com")
      expect(user2).to_not be_valid
    end

    it "has a unique email" do
      user2 = build(:user, email: @user1.email)
      expect(user2).to_not be_valid
    end

    it "generates unique username" do
      user2 = build(:user, email: "#{@user1.email.split('@').first}@gmail.com")
      expect(user2).to be_valid
    end

    it "is not valid without a password" do
      user2 = build(:user, password: nil)
      expect(user2).to_not be_valid
    end

    it "is not valid when password does not match confirmation password" do
      password = "john"
      user2 = build(:user, password: password, password_confirmation: "" )
      expect(user2).to_not be_valid
    end

    it "is not valid when password contains less than than 8 characters" do
      password = "john"
      user2 = build(:user, password: password, password_confirmation: password )
      expect(user2).to_not be_valid
    end

    it "is not valid when username contains less than five characters" do
      @user1.update(username: "abc")
      expect(@user1).to_not be_valid
    end

    it "has a unique username" do
      user2 = build(:user, email: "person1@gmail.com")
      user2.update(username: "person1")
      expect(@user1).to_not be_valid
    end

  end

end
