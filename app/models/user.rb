class User < ApplicationRecord
  attr_reader :password

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
end
