class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :remember_token
end
