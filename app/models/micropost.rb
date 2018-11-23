class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence:true, length: { maximum: 140 }
  validates :user_id, presence: true
  before_validation :assign_in_reply_to

  MICROPOSTS_PER_PAGE = 30

  scope :including_replies_to, ->(user) { where(in_reply_to: user.user_name) }

  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end

  def assign_in_reply_to
    first_word = content.split(" ").first
    if first_word.start_with?("@")
      user = User.find_by_user_name(first_word[1..-1]) rescue nil
      self.in_reply_to = user.user_name
    end
  end
end
