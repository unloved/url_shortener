require 'grape'

class API < Grape::API
  format :json
  prefix :api

  resource :urls do
    post '/' do
      {url: params['url']}
    end
  end
end