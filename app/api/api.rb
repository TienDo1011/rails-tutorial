class API < Grape::API
  include AuthHelpers

  prefix 'api'
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    error! '404 Not found', 404
  end

  rescue_from :all do |e|
    error_message = "rescued from #{e.class.name}: #{e.message}"
    puts error_message
    error!(error_message)
  end

  mount Microposts
  mount Relationships
  mount Users
end