class User < ApplicationRecord

  validates :email, presence: true
  validates :name, presence: true

  validates :name, length: { minimum: 2, maximum: 150 }, allow_blank: true

  validates :username, length: { minimum: 5, maximum: 150 }, allow_blank: true, on: :update
  validates :username, uniqueness: true, allow_blank: true, on: :update

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :email, uniqueness: true, allow_blank: true

  has_secure_password validations: false

  def password=(value)
    super(value)
    self.password_digest = nil if value.blank?
  end

  validate do |record|
    record.errors.add(:password, :blank) unless record.password_digest.present?
  end

  validates_length_of :password, within: 8..ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED, allow_blank: true
  validates_confirmation_of :password, allow_blank: true

  before_save { self.email = email.downcase }

  before_create :set_default_columns

  def send_password_reset_mail
    self.reset_password_token = generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.reset_password(id).deliver_now
  end

  def password_reset_expired?
    Time.zone.now > ( reset_password_sent_at + (6.hours) )
  end

  def set_reset_fields_to_nil
    update(reset_password_token: nil, reset_password_sent_at: nil)
  end

  private

  def set_default_columns
    self.username = email.split("@").first

    counter = 1
    while User.exists?(username: username)
      self.username = "#{username}#{counter}"
      counter += 1
    end

    self.auth_token = generate_token(:auth_token)

  end


  def generate_token(column)
    loop do
      token = SecureRandom.hex(16)
      break token unless User.exists?(column => token)
    end
  end

end
