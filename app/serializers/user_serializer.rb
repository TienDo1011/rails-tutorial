class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :digest_token
end
