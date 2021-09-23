class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token

  before_save :downcase_email   #  обычно предпочтительнее использовать ссылки на методы, а не явный блок
  before_create :create_activation_digest

  validates(:name, presence: true, length: { maximum: 50 })
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true)
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  # метод класса
  def self.new_token
    SecureRandom.urlsafe_base64
    # при получении cookie с постоянным идентификатором необходимо найти
    # пользователя в базе данных и убедиться, что токен в cookie совпадает со свя-
    # занным дайджестом в базе данных
  end

  # Запоминает пользователя в БАЗЕ ДАННЫХ для использования в постоянных сеансах.
  def remember
    self.remember_token = User.new_token # self гарантирует, что присваивание будет выполнено пользовательскому атрибуту
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  # Возвращает true, если указанный токен соответствует дайджесту.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
    # update_attribute(:activated, true)
    # update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    # update_attribute(:reset_digest, User.digest(reset_token))
    # update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired
  # Возвращает true, если время для сброса пароля истекло
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

  def downcase_email
    self.email = email.downcase #  обычно предпочтительнее использовать ссылки на методы
  end

  # Create the token and digest.
  def create_activation_digest
    self.activation_token = User.new_token # создаем токен для пользователя
    self.activation_digest = User.digest(activation_token) # создаем дайджест для пользователя на основании токена, оба - виртуальные атрибуты модели
  end
end
