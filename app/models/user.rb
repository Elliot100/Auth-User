class User < ApplicationRecord
    attr_reader :password

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 , allow_nil: true}
    validates :password_digest, presence: { message: "Password can\t be blank"}
    before_validation :ensure_session_token

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && BCrypt::Password.new(user.password_digest).is_password?(password)
            return user
        end
        nil
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

end
