module Twitter
  class API < Grape::API
    version 'v1', using: :header, vendor: 'twitter'
    format :json
    prefix :api

    resource :users do
      desc 'Returns list of users'
      get do
        User.all
      end
    end
  end
end