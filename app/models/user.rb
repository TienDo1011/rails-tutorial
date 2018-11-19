class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { self.email = email.downcase }
  before_create :create_digest_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_USER_NAME = /\w+/i
  validates :user_name, presence: true, format: { with: VALID_USER_NAME },
    uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  USERS_PER_PAGE = 10

  def User.token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(user_or_id)
    relationships.find_by(followed_id: extract_id(user_or_id))
  end

  def follow!(user_or_id)
    relationships.create!(followed_id: extract_id(user_or_id))
  end

  def unfollow!(user_or_id)
    relationships.find_by(followed_id: extract_id(user_or_id)).destroy
  end

  private
    def create_digest_token
      self.digest_token = User.digest(User.token)
    end

    def extract_id(user_or_id)
      user_or_id.is_a?(Integer) ? user_or_id : user_or_id.id
    end
end
