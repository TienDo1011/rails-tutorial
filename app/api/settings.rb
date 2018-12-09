class Settings < Grape::API
  helpers AuthHelpers

  resource :settings do
    desc "Get user configuration"
    get do
      authenticate!
      current_user.user_configuration
    end

    desc "Update configuration"
    params do
      requires :should_notify, type: Boolean
    end
    put do
      authenticate!
      current_user.user_configuration.update(should_notify: params[:should_notify])
      current_user.user_configuration
    end
  end
end
