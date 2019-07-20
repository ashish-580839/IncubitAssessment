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

  def send_password_reset_mail
    loop do
      self.reset_password_token = SecureRandom.hex(16)
      break unless User.exists?(reset_password_token: reset_password_token)
    end
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.reset_password(id).deliver_now
  end

  private

  def set_default_username
    self.username = email.split("@").first

    counter = 1
    while User.exists?(username: username)
      self.username = "#{username}#{counter}"
      counter += 1
    end
  end

end
