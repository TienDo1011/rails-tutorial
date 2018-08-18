class MicropostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :user_email

  def user_email
    User.find(object.user_id).email
  end
end
