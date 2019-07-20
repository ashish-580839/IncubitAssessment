class User < ApplicationRecord

  validates :email, presence: true
  validates :name, presence: true

  validates :name, length: { minimum: 2, maximum: 200 }, allow_blank: true

  validates :username, length: { minimum: 5, maximum: 150 }, allow_blank: true, on: :update
  validates :username, uniqueness: true, allow_blank: true, on: :update

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :email, uniqueness: true, allow_blank: true


  validates :password, length: { minimum: 8 }, allow_blank: true

  has_secure_password

  before_create :set_default_username

  private

  def set_default_username
    default_username = email.split("@").first

    counter = 1
    while User.exists?(username: default_username)
      default_username = "#{default_username}#{counter}"
      counter += 1
    end

    self.username = default_username
  end

end
