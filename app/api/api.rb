class API < Grape::API
  prefix 'api'
  format :json

  mount Twitter::Micropost
end