module ErrorsHelper
  def get_error(object)
    object.errors.full_messages[0]
  end
end