class User < ApplicationRecord

  validates :email, presence: true

  validates :username, length: { minimum: 5, maximum: 150 }, allow_blank: true, on: :update
  validates :username, uniqueness: true, allow_blank: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :email, uniqueness: true, allow_blank: true



  validates :password, length: { minimum: 8 }, allow_blank: true

  has_secure_password

  before_create :user_signup

  private

  def user_signup
    self.username = email.split("@").first
  end

end
