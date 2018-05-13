require 'grape'
require './app/models/url'

class API < Grape::API
  format :json
  get "/:key" do
    url = Url.where(key: params[:key]).first
    if url.present?
      redirect url.original_url
    else
      redirect '/error.html'
    end
  end

  namespace :api do
    resource :urls do
      post '/' do
        url = Url.new(original_url: params[:url])
        if url.save
          {url: url.key}
        else
          error!({error: url.errors[:original_url].join(', ')})
        end
      end
    end
  end
end