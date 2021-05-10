class User < ApplicationRecord
  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true

  # the password needs to allow nil so updating records will work
  # as when a record is pulled from the db, it won't have a password
  # just a password hash
  validates :password, length: { minimum: 8}, allow_nil: true
  validate :email_is_well_formed

  has_many :recurring_items, dependent: :destroy
  has_many :non_recurring_items, dependent: :destroy

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    # requires both the correct email and password to avoid giving 
    # unecessary information in case of mismatching email and password
    user = User.find_by(email: email)
    user = nil if user && !user.is_password?(password)

    user
  end

  def password=(password)
    @password = password

    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
  end

  private 

  def email_is_well_formed
    valid_email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    if self.email !~ valid_email_regex
      self.errors[:email] << 'is not a valid email address'
    end
  end
end
