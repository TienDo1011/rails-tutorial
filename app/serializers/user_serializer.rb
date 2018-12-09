class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :admin
  has_many :microposts
  has_many :followers
  has_many :followed_users, key: :followings
  has_one :user_configuration, key: :settings, serializer: UserConfigurationSerializer
end
